//
//  Usage.swift
//  bbc
//
//  Created by Robin Hayward on 15/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

public enum UsageReportError: Error {
  case badRequestData
  case requestFailed // TODO.. add more granular error reporting
}

public struct UsageReport {
  enum Name: String {
    case load, display, error
  }

  let name: UsageReport.Name
  let data: [String: String]
  let created: TimeInterval = Date.timeIntervalSinceReferenceDate
}

public protocol UsageReporter: class {
  func register(_ report: UsageReport, completion: ((UsageReportError?) -> ())?)
}

class Usage: UsageReporter {
  let api: APIInterface

  init(api: APIInterface) {
    self.api = api
  }

  func register(_ report: UsageReport, completion: ((UsageReportError?) -> ())?) {
    api.track(report, completion)
  }
}
