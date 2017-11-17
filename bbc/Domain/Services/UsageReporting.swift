//
//  Usage.swift
//  bbc
//
//  Created by Robin Hayward on 15/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

struct UsageReport {
  enum Name: String {
    case load, display, error
  }

  let name: UsageReport.Name
  let data: [String: String]
}

protocol UsageReporter {
  func register(_ report: UsageReport)
}

class Usage: UsageReporter {
  let api: APIInterface

  init(api: APIInterface = API()) {
    self.api = api
  }

  func register(_ report: UsageReport) {
    api.send(report)
  }
}
