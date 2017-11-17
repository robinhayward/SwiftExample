//
//  Usage.swift
//  bbc
//
//  Created by Robin Hayward on 15/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

struct UsageReport {
  let name: String
  let data: [String: String]
}

protocol UsageReporter {
  func register(_ report: UsageReport)
}

class Usage: UsageReporter {
  let session: URLSession

  init(session: URLSession = URLSession.shared) {
    self.session = session
  }

  func register(_ report: UsageReport) {

  }
}

// MARK: - Housekeep

class UsageReportToUrl {
  class func execute(url: String, report: UsageReport) -> String {
    var query: String = "event=\(report.name)"
    for key in report.data.keys {
      query = "\(query)&\(key)=\(report.data[key]!)"
    }

    return "\(url)?\(query)"
  }
}
