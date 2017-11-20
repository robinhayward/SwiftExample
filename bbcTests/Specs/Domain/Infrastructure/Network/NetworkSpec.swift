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
        context("always") {
          let request = URLRequest(url: URL(string: "https://api.com")!)

          beforeEach {
            sut.run(request) { r in }
          }
          it("starts a data task with the url request") {
            expect(session.request).to(equal(request))
            expect(session.requestInProgress).toNot(beNil())
            expect(session.requestInProgress?.resumed).to(beTrue())
          }
        }

        context("completion") {
          let request = URLRequest(url: URL(string: "https://api.com")!)
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
    }
  }
}

class NetworkReporterSpy: NetworkReporter {
  var reportedResponse: NetworkResponse?

  func report(_ response: NetworkResponse) {
    self.reportedResponse = response
  }
}
