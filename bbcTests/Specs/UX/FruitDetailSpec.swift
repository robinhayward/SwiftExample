//
//  FruitDetailSpec.swift
//  bbcTests
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import bbc

class FruitDetailSpec: QuickSpec {
  override func spec() {
    var sut: FruitDetailView!
    var ui: FruitDetailUISpy!
    var assembly: FruitDetailAssemblyTest!

    describe("Fruit detail") {
      beforeEach {
        assembly = FruitDetailAssemblyTest()
      }
      describe("when the user first arrives") {
        beforeEach {
          ui = FruitDetailUISpy()
          
          sut = FruitDetailAssembler.assemble(assembly: assembly) as! FruitDetailView
          sut.presenter.ui = ui

          sut.viewWillAppear(false)
        }
        it("sends the correct usage report for display") {
          let usage = assembly.usage as! UsageReporterSpy

          expect(usage.regiesteredReport).toNot(beNil())
          expect(usage.regiesteredReport?.name).to(equal(UsageReport.Name.display))
          expect(usage.regiesteredReport?.data["fruit-type"]).to(equal(assembly.fruit.type))
        }
        it("updates the ui with the correctly formatted fruit information") {
          expect(ui.content?.doneButtonTitle).to(equal("DONE"))
          expect(ui.content?.fruitName).to(equal("Apple"))
          expect(ui.content?.priceTitle).to(equal("Price"))
          expect(ui.content?.priceValue).to(equal("1"))
          expect(ui.content?.weightTitle).to(equal("Weight"))
          expect(ui.content?.weightValue).to(equal("2"))
        }
      }

      describe("when the user is done") {
        beforeEach {
          ui = FruitDetailUISpy()

          sut = FruitDetailAssembler.assemble(assembly: assembly) as! FruitDetailView
          sut.presenter.ui = ui

          sut.viewWillAppear(false)
          sut.user.done()
        }
        it("notifies the wireframe") {
          let wireframe = assembly.wireframe as! FruitDetailWireframeSpy

          expect(wireframe.fruitDetailDoneCalled).to(beTrue())
        }
      }
    }
  }
}

class FruitDetailAssemblyTest: FruitDetailAssembly {
  var wireframe: FruitDetailWireframe = FruitDetailWireframeSpy()
  var fruit: Fruit = FruitFactory.apple()
  var usage: UsageReporter = UsageReporterSpy()
}

class FruitDetailUISpy: FruitDetailUI {
  var content: FruitDetailViewContent?

  func update(_ content: FruitDetailViewContent) {
    self.content = content
  }
}

class FruitDetailWireframeSpy: FruitDetailWireframe {
  var fruitDetailDoneCalled = false

  func fruitDetailDone() {
    fruitDetailDoneCalled = true
  }
}
