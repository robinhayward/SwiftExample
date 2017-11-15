//
//  FruitRepository.swift
//  bbc
//
//  Created by Robin Hayward on 15/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

enum GroceryError: Error {
  case connectionError, serverError
}

typealias GroceryResult = Result<[Fruit], GroceryError>

protocol GroceryAssistant {
  func fruit(completion: @escaping (GroceryResult) -> ())
}

class Grocery: GroceryAssistant {
  func fruit(completion: @escaping (GroceryResult) -> ()) {
    let fruit = [
      FruitEntity(uuid: NSUUID().uuidString, name: "Apple"),
      FruitEntity(uuid: NSUUID().uuidString, name: "Banana"),
      FruitEntity(uuid: NSUUID().uuidString, name: "Strawberry"),
    ]

    completion(GroceryResult(fruit))
  }
}


