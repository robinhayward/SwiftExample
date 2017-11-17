//
//  UsageSpec.swift
//  bbcTests
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import bbc

class UsageSpec: QuickSpec {
  override func spec() {
    var sut: UsageReporter!
    var api: APIInterfaceFake!

    describe("Usage") {
      beforeEach {
        api = APIInterfaceFake()
        sut = Usage(api: api)
      }

      describe("usage") {
        let report = UsageReport(name: UsageReport.Name.display, data: ["fruit-type": "apple"])

        beforeEach {
          sut.register(report) { e in }
        }
        it("sends a valid url request to the api") {
          expect(api.request).toNot(beNil())
          expect(api.request?.url?.absoluteString).to(equal("https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/stats?event=display&fruit-type=apple"))
          expect(api.request?.httpMethod).to(equal("GET"))
        }
      }

      describe("usage") {
        context("success") {
          let report = UsageReport(name: UsageReport.Name.display, data: ["fruit-type": "apple"])
          var error: UsageReportError?

          beforeEach {
            sut.register(report) { e in
              error = e
            }
            api.completion?(NetworkResponseFactory.statusTwoHundredNoDataExpected())
          }
          it("fires the completion block without an error") {
            expect(error).to(beNil())
          }
        }

        describe("failure") {
          context("server error") {
            let report = UsageReport(name: UsageReport.Name.display, data: ["fruit-type": "apple"])
            var error: UsageReportError?

            beforeEach {
              sut.register(report) { e in
                error = e
              }
              api.completion?(NetworkResponseFactory.serverError())
            }
            it("fires the completion block without an error") {
              expect(error).to(equal(UsageReportError.requestFailed))
            }
          }
        }
      }
    }
  }
}
