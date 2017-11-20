//
//  UserReporterSpy.swift
//  bbcTests
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

@testable import bbc

class UsageReporterSpy: UsageReporter {
  var reports: [UsageReport] = [UsageReport]()

  func register(_ report: UsageReport, completion: ((UsageReportError?) -> ())?) {
    reports.append(report)
  }
}
