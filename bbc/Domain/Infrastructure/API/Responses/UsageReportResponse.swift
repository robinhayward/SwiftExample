//
//  UsageReportResponse.swift
//  bbc
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

class UsageReportResponse {
  private struct FruitPage: Codable {
    let fruit: [Fruit]
  }

  class func handle(_ input: NetworkResponse) -> UsageReportError? {
    guard input.error == nil else { return .requestFailed }
    guard input.statusCode == 200 else { return .requestFailed }

    return nil
  }
}
