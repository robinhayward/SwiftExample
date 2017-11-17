//
//  Usage.swift
//  bbc
//
//  Created by Robin Hayward on 15/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

enum UsageReportError: Error {
  case badRequestData
  case requestFailed // TODO.. add more granular error reporting
}

struct UsageReport {
  enum Name: String {
    case load, display, error
  }

  let name: UsageReport.Name
  let data: [String: String]
}

protocol UsageReporter {
  func register(_ report: UsageReport, completion: ((UsageReportError?) -> ())?)
}

class Usage: UsageReporter {
  let api: API

  init(api: API = API.shared) {
    self.api = api
  }

  func register(_ report: UsageReport, completion: ((UsageReportError?) -> ())?) {
    guard let request = UsageReportRequest(config: api.config, report: report).create() else {
      completion?(UsageReportError.badRequestData)
      return
    }

    api.run(request) { response in
      completion?(UsageReportResponse.handle(response))
    }
  }
}
