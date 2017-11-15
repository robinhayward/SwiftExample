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
  let session: URLSession

  init(session: URLSession = URLSession.shared) {
    self.session = session
  }

  func fruit(completion: @escaping (GroceryResult) -> ()) {
    let url = URL(string: "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/data.json")!
    let request = URLRequest(url: url)

    let task = session.dataTask(with: request) { (data, response, error) in
      let input = URLResponseInput(data, response, error)
      let result = GroceryFetchRequestHandler.handle(input)

      SwitchToMainThread.with {
        completion(result)
      }
    }

    task.resume()
  }
}

struct FruitPageRaw: Codable {
  let fruit: [Fruit]
}

struct URLResponseInput: CustomDebugStringConvertible {
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

class GroceryFetchRequestHandler {
  class func handle(_ input: URLResponseInput) -> GroceryResult {
    if let _ = input.error {
      return GroceryResult(.server)
    }

    if let data = input.data {
      do {
        let jsonDecoder = JSONDecoder()
        let page = try jsonDecoder.decode(FruitPageRaw.self, from: data)
        return GroceryResult(page.fruit)
      }
      catch {
        return GroceryResult(.data)
      }
    }

    return GroceryResult(.unknown)
  }
}
