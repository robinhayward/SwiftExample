//
//  ApiResponse.swift
//  bbc
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

struct APIResponse: CustomDebugStringConvertible {
  let data: Data?
  let response: URLResponse?
  let error: Error?

  var debugDescription: String {
    var info = ""
    if let data = data, let dataString = String(data: data, encoding: .utf8) {
      info = info + dataString
    }

    return info
  }

  init(_ data: Data?, _ response: URLResponse?, _ error: Error?) {
    self.data = data
    self.response = response
    self.error = error
  }
}