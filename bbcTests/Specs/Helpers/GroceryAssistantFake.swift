//
//  GroceryAssistantFake.swift
//  bbcTests
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

@testable import bbc

class GroceryAssistantFake: GroceryAssistant {
  var completion: ((GroceryResult) -> ())?

  func fruit(completion: @escaping (GroceryResult) -> ()) {
    self.completion = completion
  }

  func reset() {
    completion = nil
  }

  func success(_ fruit: [Fruit]) {
    completion?(GroceryResult(fruit))
  }

  func failure() {
    completion?(GroceryResult(.requestFailed))
  }
}
