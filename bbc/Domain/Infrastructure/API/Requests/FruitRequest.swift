//
//  FruitRequest.swift
//  bbc
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

struct FruitRequest {
  let config: APIConfig

  private let resource = "/data.json"

  func create() -> NetworkRequest? {
    guard let url = URL(string: "\(config.host)\(resource)") else {
      return nil
    }
    let request = NSMutableURLRequest(url: url)
    request.httpMethod = "GET"

    return NetworkRequest(urlRequest: request as URLRequest, report: true)
  }
}
