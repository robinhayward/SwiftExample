//
//  FruitRepository.swift
//  bbc
//
//  Created by Robin Hayward on 15/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import UIKit

public enum GroceryError: Error {
  case unknown
  case badDataReceived
  case requestFailed // TODO.. add more granular error reporting
}

public typealias GroceryResult = Result<[Fruit], GroceryError>

public protocol GroceryAssistant: class {
  func fruit(completion: @escaping (GroceryResult) -> ())
}

class Grocery: GroceryAssistant {
  let api: APIInterface

  init(api: APIInterface) {
    self.api = api
  }

  func fruit(completion: @escaping (GroceryResult) -> ()) {
    api.fruit(completion)
  }
}
