//
//  APIRequests.swift
//  bbc
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

struct FruitRequest {
  let config: APIConfig

  private let resource = "/data.json"

  func create() -> URLRequest? {
    guard let url = URL(string: "\(config.host)\(resource)") else {
      return nil
    }
    let request = NSMutableURLRequest(url: url)
    request.httpMethod = "GET"

    return request as URLRequest
  }
}

struct UsageReportRequest {
  let config: APIConfig
  let report: UsageReport

  private let resource = "/stats"

  func create() -> URLRequest? {
    guard let url = url() else { return nil }

    let request = NSMutableURLRequest(url: url)
    request.httpMethod = "GET"

    return request as URLRequest
  }

  private func url() -> URL? {
    var query: String = "event=\(report.name.rawValue)"
    for key in report.data.keys {
      guard
        let encodedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
        let encodedValue = report.data[key]?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else { return nil }
      query = "\(query)&\(encodedKey)=\(encodedValue)"
    }

    return URL(string: "\(config.host)\(resource)?\(query)")
  }
}
