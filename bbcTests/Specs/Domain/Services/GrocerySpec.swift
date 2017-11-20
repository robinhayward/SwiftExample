//
//  GrocerySpec.swift
//  bbcTests
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import bbc

class GrocerySpec: QuickSpec {
  override func spec() {
    var sut: Grocery!
    var api: APISpy!

    describe("Grocery") {
      beforeEach {
        api = APISpy()
        sut = Grocery(api: api)
      }

      describe("fruit") {
        context("success") {
          var result: GroceryResult?

          beforeEach {
            sut.fruit { r in
              result = r
            }
            api.fruitCompletion?(GroceryResult([FruitFactory.apple()]))
          }
          it("has a success result with fruit") {
            expect(result).toNot(beNil())
            expect(result?.successful()).to(beTrue())
          }
        }
      }

      describe("fruit") {
        context("failure") {
          var result: GroceryResult?

          beforeEach {
            sut.fruit { r in
              result = r
            }
            api.fruitCompletion?(GroceryResult(GroceryError.requestFailed))
          }
          it("has a failure result with an error") {
            expect(result).toNot(beNil())
            expect(result?.error()).toNot(beNil())
            expect(result?.error()).to(equal(GroceryError.requestFailed))
          }
        }
      }
    }
  }
}

class APISpy: APIInterface {
  var fruitCompletion: ((GroceryResult) -> ())?
  var trackCompletion: ((UsageReportError?) -> ())?

  func fruit(_ completion: @escaping ((GroceryResult) -> ())) {
    fruitCompletion = completion
  }

  func track(_ report: UsageReport, _ completion: ((UsageReportError?) -> ())?) {
    trackCompletion = completion
  }
}
