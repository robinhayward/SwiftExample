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
    var api: API!
    var network: NetworkFake!

    describe("Grocery") {
      beforeEach {
        network = NetworkFake()
        api = API(network: network)
        sut = Grocery(api: api)
      }

      describe("fruit") {
        beforeEach {
          sut.fruit { r in }
        }
        it("sends a valid url request to the api") {
          expect(network.request).toNot(beNil())
          expect(network.request?.url?.absoluteString).to(equal("https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/data.json"))
          expect(network.request?.httpMethod).to(equal("GET"))
        }
      }

      describe("fruit") {
        context("success") {
          var result: GroceryResult?

          beforeEach {
            sut.fruit { r in
              result = r
            }
            network.completion?(NetworkResponseFactory.fruit())
          }
          it("has a success result with fruit") {
            expect(result).toNot(beNil())
            expect(result?.successful()).to(beTrue())
          }
        }

        describe("failure") {
          context("server error") {
            var result: GroceryResult?

            beforeEach {
              sut.fruit { r in
                result = r
              }
              network.completion?(NetworkResponseFactory.serverError())
            }
            it("has a failure result with an error") {
              expect(result).toNot(beNil())
              expect(result?.error()).toNot(beNil())
              expect(result?.error()).to(equal(GroceryError.requestFailed))
            }
          }

          context("bad json") {
            var result: GroceryResult?

            beforeEach {
              sut.fruit { r in
                result = r
              }
              network.completion?(NetworkResponseFactory.badFruit())
            }
            it("has a failure result with an error") {
              expect(result).toNot(beNil())
              expect(result?.error()).toNot(beNil())
              expect(result?.error()).to(equal(GroceryError.badDataReceived))
            }
          }
        }
      }
    }
  }
}
