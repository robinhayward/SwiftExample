//
//  Supermarket.swift
//  bbc
//
//  Created by Robin Hayward on 20/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

public protocol Supermarket {
  func grocer() -> GroceryAssistant
  func reporter() -> UsageReporter
}

public class SupermarketSDK: Supermarket {
  private let api: APIInterface
  private let usage: UsageReporter

  public init() {
    self.api = API()
    self.usage = Usage(api: api)
  }

  public func grocer() -> GroceryAssistant {
    return Grocery(api: api)
  }

  public func reporter() -> UsageReporter {
    return usage
  }
}
