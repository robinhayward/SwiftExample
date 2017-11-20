//
//  UsageReportRequestSpec.swift
//  bbcTests
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import bbc

class UsageReportRequestSpec: QuickSpec {
  override func spec() {
    var sut: UsageReportRequest!
    let config = APIConfig()
    let report = UsageReport(name: UsageReport.Name.display, data: ["fruit-type": "apple", "unencoded": "encode me ! please 23"])

    describe("UsageReportRequest") {
      beforeEach {
        sut = UsageReportRequest(config: config, report: report)
      }

      describe("create") {
        it("returns a valid request") {
          let request = sut.create()
          expect(request).toNot(beNil())
          expect(request.urlRequest.url?.absoluteString).to(equal("https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/stats?event=display&unencoded=encode%20me%20!%20please%2023&fruit-type=apple"))
          expect(request.urlRequest.httpMethod).to(equal("GET"))
        }
      }
    }
  }
}
