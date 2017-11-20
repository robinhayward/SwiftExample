//
//  FruitResponseSpec.swift
//  bbcTests
//
//  Created by Robin Hayward on 20/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import bbc

class FruitResponseSpec: QuickSpec {
  override func spec() {
    describe("Fruit response") {
      describe("handle") {
        context("expected response") {
          it("has success") {
            let response = NetworkResponseFactory.fruit()

            let result = FruitResponse.handle(response)

            expect(result.successful()).to(beTrue())
            expect(result.data()?.count).to(equal(2))
          }
        }

        context("unexpected response data") {
          it("has failure") {
            let response = NetworkResponseFactory.badFruit()

            let result = FruitResponse.handle(response)

            expect(result.successful()).to(beFalse())
            expect(result.error()).to(equal(GroceryError.badDataReceived))
          }
        }

        context("server error") {
          it("has failure") {
            let response = NetworkResponseFactory.serverError()

            let result = FruitResponse.handle(response)

            expect(result.successful()).to(beFalse())
            expect(result.error()).to(equal(GroceryError.requestFailed))
          }
        }

        context("connection error") {
          it("has failure") {
            let response = NetworkResponseFactory.connectionError()

            let result = FruitResponse.handle(response)

            expect(result.successful()).to(beFalse())
            expect(result.error()).to(equal(GroceryError.requestFailed))
          }
        }
      }
    }
  }
}

