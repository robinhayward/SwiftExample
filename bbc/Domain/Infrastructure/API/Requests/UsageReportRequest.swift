//
//  UsageReportRequest.swift
//  bbc
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

struct UsageReportRequest {
  let config: APIConfig
  let report: UsageReport

  private let resource = "/stats"

  func create() -> NetworkRequest {
    let url = createUrl()
    let request = NSMutableURLRequest(url: url)
    request.httpMethod = "GET"

    return NetworkRequest(urlRequest: request as URLRequest, report: false)
  }

  private func createUrl() -> URL {
    var query: String = "event=\(report.name.rawValue)"
    for key in report.data.keys {
      if let parameter = validParameter(key, report.data[key]) {
        query = "\(query)&\(parameter)"
      }
    }

    return URL(string: "\(config.host)\(resource)?\(query)")!
  }

  private func validParameter(_ key: String, _ value: String?) -> String? {
    guard
      let encodedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
      let encodedValue = value?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    else { return nil }

    return "\(encodedKey)=\(encodedValue)"
  }
}
