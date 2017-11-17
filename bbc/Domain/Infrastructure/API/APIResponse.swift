//
//  ApiResponse.swift
//  bbc
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

struct APIResponse: CustomStringConvertible {
  let data: Data?
  let response: URLResponse?
  let error: Error?
  let duration: TimeInterval

  var statusCode: Int? { return (response as? HTTPURLResponse)?.statusCode }

  var description: String {
    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
    var info = "HTTP Status Code: \(statusCode)\n"
    info = info + "Duration: \(duration) seconds"

    if let data = data, let dataString = String(data: data, encoding: .utf8) {
      info = info + dataString
    }

    return info
  }

  init(_ data: Data?, _ response: URLResponse?, _ error: Error?, _ duration: TimeInterval) {
    self.data = data
    self.response = response
    self.error = error
    self.duration = duration
  }
}
