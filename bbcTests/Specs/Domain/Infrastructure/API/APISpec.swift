//
//  APISpec.swift
//  bbcTests
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import bbc

class APISpec: QuickSpec {
  override func spec() {
    var sut: API!
    var network: NetworkFake!
    var reporter: UsageReporterSpy!

    describe("API") {
      beforeEach {
        reporter = UsageReporterSpy()
        network = NetworkFake()
        sut = API(network: network)
        sut.usage = reporter
      }

      describe("creation") {
        beforeEach {
          sut = API(network: network)
        }
        it("assigns itself a usage reporter") {
          expect(sut.usage).toNot(beNil())
        }
        it("assigns itself as the network reporter") {
          expect(network.reporter).toNot(beNil())
        }
      }

      describe("network reporting") {
        context("on network request success") {
          beforeEach {
            sut.fruit { r in }
            network.completeLastRequest(with: NetworkResponseFactory.fruit())
          }
          it("sends a valid report of the network request response") {
            expect(reporter.reports.first).toNot(beNil())
            expect(reporter.reports.first?.name).to(equal(UsageReport.Name.load))
            expect(reporter.reports.first?.data["data"]).to(equal("176"))
            expect(reporter.reports.first?.data["duration"]).to(equal("0.7"))
          }
        }

        context("on network request failure") {
          beforeEach {
            sut.fruit { r in }
            network.completeLastRequest(with: NetworkResponseFactory.serverError())
          }
          it("sends a valid report of the network request response") {
            expect(reporter.reports.first).toNot(beNil())
            expect(reporter.reports.first?.name).to(equal(UsageReport.Name.load))
            expect(reporter.reports.first?.data["data"]).to(equal("0"))
            expect(reporter.reports.first?.data["duration"]).to(equal("0.1"))
          }
        }
      }

      describe("fruit") {
        beforeEach {
          sut.fruit { r in }
        }
        it("sends a valid request to the network") {
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
            network.completeLastRequest(with: NetworkResponseFactory.fruit())
          }
          it("sends a valid request to the network") {
            expect(network.request).toNot(beNil())
            expect(network.request?.url?.absoluteString).to(equal("https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/data.json"))
            expect(network.request?.httpMethod).to(equal("GET"))
          }
          it("fires the completion block with fruit") {
            expect(result).toNot(beNil())
            expect(result?.successful()).to(beTrue())
          }
        }
      }

      describe("fruit") {
        context("bad json") {
          var result: GroceryResult?

          beforeEach {
            sut.fruit { r in
              result = r
            }
            network.completeLastRequest(with: NetworkResponseFactory.badFruit())
          }
          it("has a failure result with an error") {
            expect(result).toNot(beNil())
            expect(result?.error()).toNot(beNil())
            expect(result?.error()).to(equal(GroceryError.badDataReceived))
          }
        }
      }

      describe("fruit") {
        context("server error") {
          var result: GroceryResult?

          beforeEach {
            sut.fruit { r in
              result = r
            }
            network.completeLastRequest(with: NetworkResponseFactory.serverError())
          }
          it("has a failure result with an error") {
            expect(result).toNot(beNil())
            expect(result?.error()).toNot(beNil())
            expect(result?.error()).to(equal(GroceryError.requestFailed))
          }
        }
      }

      describe("track") {
        let report = UsageReport(name: UsageReport.Name.display, data: ["fruit-type": "apple"])

        beforeEach {
          sut.track(report) { e in }
        }
        it("sends a valid request to the network") {
          expect(network.request).toNot(beNil())
          expect(network.request?.url?.absoluteString).to(equal("https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/stats?event=display&fruit-type=apple"))
          expect(network.request?.httpMethod).to(equal("GET"))
        }
      }

      describe("track") {
        context("success") {
          let report = UsageReport(name: UsageReport.Name.display, data: ["fruit-type": "apple"])
          var error: UsageReportError?

          beforeEach {
            sut.track(report) { e in
              error = e
            }
            network.completeLastRequest(with: NetworkResponseFactory.statusTwoHundredNoDataExpected())
          }
          it("fires the completion block without an error") {
            expect(error).to(beNil())
          }
        }
      }

      describe("track") {
        context("server error") {
          let report = UsageReport(name: UsageReport.Name.display, data: ["fruit-type": "apple"])
          var error: UsageReportError?

          beforeEach {
            sut.track(report) { e in
              error = e
            }
            network.completeLastRequest(with: NetworkResponseFactory.serverError())
          }
          it("fires the completion block with an error") {
            expect(error).to(equal(UsageReportError.requestFailed))
          }
        }
      }
      
    }
  }
}

