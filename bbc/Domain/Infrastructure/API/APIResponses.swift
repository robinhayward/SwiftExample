//
//  APIResponseHandlers.swift
//  bbc
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

class FruitResponse {
  private struct FruitPage: Codable {
    let fruit: [Fruit]
  }

  class func handle(_ input: APIResponse) -> GroceryResult {
    guard input.error == nil else { return GroceryResult(.requestFailed) }
    guard input.statusCode == 200 else { return GroceryResult(.requestFailed) }
    guard let data = input.data else { return GroceryResult(.requestFailed) }

    do {
      let jsonDecoder = JSONDecoder()
      let page = try jsonDecoder.decode(FruitPage.self, from: data)
      return GroceryResult(page.fruit)
    }
    catch {
      return GroceryResult(.badDataReceived)
    }
  }
}

class UsageReportResponse {
  private struct FruitPage: Codable {
    let fruit: [Fruit]
  }

  class func handle(_ input: APIResponse) -> UsageReportError? {
    guard input.error == nil else { return .requestFailed }
    guard input.statusCode == 200 else { return .requestFailed }

    return nil
  }
}
