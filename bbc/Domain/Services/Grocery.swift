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
  case unknown, connection, server, data
}

typealias GroceryResult = Result<[Fruit], GroceryError>

protocol GroceryAssistant {
  func fruit(completion: @escaping (GroceryResult) -> ())
}

class Grocery: GroceryAssistant {
  let api: APIInterface

  init(api: APIInterface = API()) {
    self.api = api
  }

  func fruit(completion: @escaping (GroceryResult) -> ()) {
    api.fruit { (response) in
      completion(FruitResponseHandler.handle(response))
    }
  }
}

class FruitResponseHandler {
  private struct FruitPage: Codable {
    let fruit: [Fruit]
  }
  
  class func handle(_ input: APIResponse) -> GroceryResult {
    if let _ = input.error {
      return GroceryResult(.server)
    }

    if let data = input.data {
      do {
        let jsonDecoder = JSONDecoder()
        let page = try jsonDecoder.decode(FruitPage.self, from: data)
        return GroceryResult(page.fruit)
      }
      catch {
        return GroceryResult(.data)
      }
    }

    return GroceryResult(.unknown)
  }
}
