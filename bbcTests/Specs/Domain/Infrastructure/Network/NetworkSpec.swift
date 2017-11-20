//
//  NetworkSpec.swift
//  bbcTests
//
//  Created by Robin Hayward on 20/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Quick
import Nimble

@testable import bbc

class NetworkSpec: QuickSpec {
  override func spec() {
    describe("Network") {
      var sut: Network!
      var reporter: NetworkReporterSpy!
      var session: URLSessionFake!

      beforeEach {
        reporter = NetworkReporterSpy()
        session = URLSessionFake()
        sut = Network(session: session)
        sut.reporter = reporter
      }

      describe("run") {
        describe("always") {
          let request = NetworkRequestFactory.create()

          beforeEach {
            sut.run(request) { r in }
          }
          it("starts a data task with the url request") {
            expect(session.request).to(equal(request.urlRequest))
            expect(session.requestInProgress).toNot(beNil())
            expect(session.requestInProgress?.resumed).to(beTrue())
          }
        }

        describe("completion") {
          context("reportable request") {
            let request = NetworkRequestFactory.create()
            var result: NetworkResponse?

            let data: Data = JSONFactory.fruit()
            let http: URLResponse = HTTPURLResponseFactory.serverError()
            let error: NSError = NSError(domain: "test", code: 1, userInfo: nil)

            beforeEach {
              sut.run(request) { r in
                result = r
              }
              session.requestCompletionHandler?(data, http, error)
            }
            it("fires the completion block with a valid response object") {
              expect(result).toNot(beNil())
              expect(result?.data).toNot(beNil())
              expect(result?.response).toNot(beNil())
              expect(result?.error).toNot(beNil())
              expect(result?.duration).toNot(equal(0))
            }
            it("sends the response to the reporter") {
              expect(reporter.reportedResponse).toNot(beNil())
            }
          }
        }

        describe("completion") {
          context("non reportable request") {
            let request = NetworkRequestFactory.create(reportable: false)
            var result: NetworkResponse?

            let data: Data = JSONFactory.fruit()
            let http: URLResponse = HTTPURLResponseFactory.serverError()
            let error: NSError = NSError(domain: "test", code: 1, userInfo: nil)

            beforeEach {
              sut.run(request) { r in
                result = r
              }
              session.requestCompletionHandler?(data, http, error)
            }
            it("fires the completion block with a valid response object") {
              expect(result).toNot(beNil())
              expect(result?.data).toNot(beNil())
              expect(result?.response).toNot(beNil())
              expect(result?.error).toNot(beNil())
              expect(result?.duration).toNot(equal(0))
            }
            it("does not send the response to the reporter") {
              expect(reporter.reportedResponse).to(beNil())
            }
          }
        }
      }
    }
  }
}

class NetworkRequestFactory {
  class func create(reportable: Bool = true) -> NetworkRequest {
    return NetworkRequest(urlRequest: URLRequest(url: URL(string: "https://api.com")!), report: reportable)
  }
}

class NetworkReporterSpy: NetworkReporter {
  var reportedResponse: NetworkResponse?

  func report(_ response: NetworkResponse) {
    self.reportedResponse = response
  }
}
