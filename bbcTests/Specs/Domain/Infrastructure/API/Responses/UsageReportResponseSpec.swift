//
//  UsageReportResponseSpec.swift
//  bbcTests
//
//  Created by Robin Hayward on 20/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import bbc

class UsageReportResponseSpec: QuickSpec {
  override func spec() {
    describe("Usage report response") {
      describe("handle") {
        context("expected response") {
          it("has success") {
            let response = NetworkResponseFactory.statusTwoHundredNoDataExpected()

            let error = UsageReportResponse.handle(response)

            expect(error).to(beNil())
          }
        }

        context("unexpected status code") {
          it("has failure") {
            let response = NetworkResponseFactory.serverError()

            let error = UsageReportResponse.handle(response)

            expect(error).to(equal(UsageReportError.requestFailed))
          }
        }

        context("connection error") {
          it("has failure") {
            let response = NetworkResponseFactory.connectionError()

            let error = UsageReportResponse.handle(response)

            expect(error).to(equal(UsageReportError.requestFailed))
          }
        }
      }
    }
  }
}
