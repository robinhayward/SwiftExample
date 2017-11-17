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
  var regiesteredReport: UsageReport?

  func register(_ report: UsageReport, completion: ((UsageReportError?) -> ())?) {
    regiesteredReport = report
  }
}
