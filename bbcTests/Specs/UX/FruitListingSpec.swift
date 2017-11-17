//
//  FruitListingSpec.swift
//  bbcTests
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import bbc

class FruitListingSpec: QuickSpec {
  override func spec() {
    var sut: FruitListingView!
    var usage: UsageReporterSpy!
    var grocery: GroceryAssistantFake!
    var ui: FruitListingUISpy!
    var wireframe: FruitListingWireframeSpy!

    describe("Fruit listing") {
      describe("when the user first arrives") {
        beforeEach {
          ui = FruitListingUISpy()
          grocery = GroceryAssistantFake()
          usage = UsageReporterSpy()
          wireframe = FruitListingWireframeSpy()

          sut = FruitListingAssembler.assemble(wireframe: wireframe, grocery: grocery, usage: usage) as! FruitListingView
          sut.presenter.ui = ui

          sut.viewWillAppear(false)
        }
        it("sends the correct usage report for display") {
          expect(usage.regiesteredReport).toNot(beNil())
        }
        it("shows the loading screen") {
          expect(ui.loadingCalled).to(beTrue())
        }
      }

      describe("when fruit loads successfully") {
        beforeEach {
          ui = FruitListingUISpy()
          grocery = GroceryAssistantFake()
          usage = UsageReporterSpy()
          wireframe = FruitListingWireframeSpy()

          sut = FruitListingAssembler.assemble(wireframe: wireframe, grocery: grocery, usage: usage) as! FruitListingView
          sut.presenter.ui = ui

          sut.viewWillAppear(false)
          grocery.success(FruitFactory.two())
        }
        it("updates the ui with a list of fruit") {
          expect(ui.loadedFruit.count).to(equal(2))
        }
        it("dismisses the loading state") {
          expect(ui.finishLoadingCalled).to(beTrue())
        }
      }

      describe("when fruit loads successfully with but empty") {
        beforeEach {
          ui = FruitListingUISpy()
          grocery = GroceryAssistantFake()
          usage = UsageReporterSpy()
          wireframe = FruitListingWireframeSpy()

          sut = FruitListingAssembler.assemble(wireframe: wireframe, grocery: grocery, usage: usage) as! FruitListingView
          sut.presenter.ui = ui

          sut.viewWillAppear(false)
          grocery.success([Fruit]())
        }
        it("dismisses the loading state") {
          expect(ui.finishLoadingCalled).to(beTrue())
        }
        it("presents the no fruit available message") {
          expect(ui.noFruitAvailableCalled).to(beTrue())
        }
      }

      describe("when fruit fails to load") {
        beforeEach {
          ui = FruitListingUISpy()
          grocery = GroceryAssistantFake()
          usage = UsageReporterSpy()
          wireframe = FruitListingWireframeSpy()

          sut = FruitListingAssembler.assemble(wireframe: wireframe, grocery: grocery, usage: usage) as! FruitListingView
          sut.presenter.ui = ui

          sut.viewWillAppear(false)
          grocery.failure()
        }
        it("dismisses the loading state") {
          expect(ui.finishLoadingCalled).to(beTrue())
        }
        it("presents an error") {
          expect(ui.recievedError).toNot(beNil())
        }
      }

      describe("when there was an error loading fruit") {
        describe("retry") {
          beforeEach {
            ui = FruitListingUISpy()
            grocery = GroceryAssistantFake()
            usage = UsageReporterSpy()
            wireframe = FruitListingWireframeSpy()

            sut = FruitListingAssembler.assemble(wireframe: wireframe, grocery: grocery, usage: usage) as! FruitListingView
            sut.presenter.ui = ui

            sut.viewWillAppear(false)
            grocery.failure()
            sut.user.refresh()
            grocery.success(FruitFactory.two())
          }
          it("presents the loaded fruit") {
            expect(ui.loadedFruit.count).to(equal(2))
          }
        }
      }

      describe("when fruit is loaded") {
        describe("pull to refresh") {
          beforeEach {
            ui = FruitListingUISpy()
            grocery = GroceryAssistantFake()
            usage = UsageReporterSpy()
            wireframe = FruitListingWireframeSpy()

            sut = FruitListingAssembler.assemble(wireframe: wireframe, grocery: grocery, usage: usage) as! FruitListingView
            sut.presenter.ui = ui

            sut.viewWillAppear(false)
            grocery.success(FruitFactory.two())
            grocery.reset()
            sut.user.refresh()
            grocery.success(FruitFactory.three())
          }
          it("presents the refreshed fruit") {
            expect(ui.loadedFruit.count).to(equal(3))
          }
        }
      }

      describe("when the user selects a fruit") {
        beforeEach {
          grocery = GroceryAssistantFake()
          usage = UsageReporterSpy()
          wireframe = FruitListingWireframeSpy()

          sut = FruitListingAssembler.assemble(wireframe: wireframe, grocery: grocery, usage: usage) as! FruitListingView

          sut.loadView()
          sut.viewWillAppear(false)
          grocery.success(FruitFactory.two())
          sut.user.select(sut.data[1])
        }

        it("notifies the wireframe") {
          expect(wireframe.selection).toNot(beNil())
          expect(wireframe.selection?.type).to(equal("pear"))
        }
      }
    }
  }
}

// MARK: - Helpers

class FruitListingWireframeSpy: FruitListingWireframe {
  var selection: Fruit?

  func fruitListingSelected(_ fruit: Fruit) {
    selection = fruit
  }
}

class FruitListingUISpy: FruitListingUI {
  var loadingCalled = false
  var finishLoadingCalled = false
  var noFruitAvailableCalled = false
  var loadedFruit: [Fruit] = [Fruit]()
  var recievedError: GroceryError?

  func loading() {
    loadingCalled = true
  }

  func noFruitAvailable() {
    noFruitAvailableCalled = true
  }

  func finishLoading() {
    finishLoadingCalled = true
  }

  func updateListing(_ fruit: [Fruit]) {
    loadedFruit = fruit
  }

  func updateListingFailure(_ error: GroceryError) {
    recievedError = error
  }
}
