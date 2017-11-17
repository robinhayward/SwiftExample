//
//  FruitRepository.swift
//  bbc
//
//  Created by Robin Hayward on 15/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import UIKit

enum GroceryError: Error {
  case unknown
  case badDataReceived
  case requestFailed // TODO.. add more granular error reporting
}

typealias GroceryResult = Result<[Fruit], GroceryError>

protocol GroceryAssistant {
  func fruit(completion: @escaping (GroceryResult) -> ())
}

class Grocery: GroceryAssistant {
  let api: APIInterface

  init(api: APIInterface = API.shared) {
    self.api = api
  }

  func fruit(completion: @escaping (GroceryResult) -> ()) {
    api.fruit(completion)
  }
}
