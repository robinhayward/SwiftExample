//
//  APIHelpers.swift
//  bbc
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

class UsageReportUrl {
  class func create(resource: String, report: UsageReport) -> URL {
    var query: String = "event=\(report.name.rawValue)"
    for key in report.data.keys {
      query = "\(query)&\(key)=\(report.data[key]!)"
    }

    return URL(string: "\(resource)?\(query)")!
  }
}
