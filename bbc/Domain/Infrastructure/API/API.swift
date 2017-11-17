//
//  API.swift
//  bbc
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

protocol APIInterface {
  func fruit(_ completion: @escaping ((GroceryResult) -> ()))
  func send(_ report: UsageReport, _ completion: ((UsageReportError?) -> ())?)
}

class API: APIInterface {
  static let shared = API(network: Network.shared)
  
  let config: APIConfig
  let network: NetworkInterface

  init(network: NetworkInterface, config: APIConfig = APIConfig()) {
    self.network = network
    self.config = config
  }

  func fruit(_ completion: @escaping ((GroceryResult) -> ())) {
    guard let request = FruitRequest(config: config).create() else {
      completion(GroceryResult(.unknown))
      return
    }

    network.run(request) { response in
      completion(FruitResponse.handle(response))
    }
  }

  func send(_ report: UsageReport, _ completion: ((UsageReportError?) -> ())?) {
    guard let request = UsageReportRequest(config: config, report: report).create() else {
      completion?(UsageReportError.badRequestData)
      return
    }

    network.run(request) { response in
      completion?(UsageReportResponse.handle(response))
    }
  }
}
