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
  func track(_ report: UsageReport, _ completion: ((UsageReportError?) -> ())?)
}

class API: APIInterface {
  let config: APIConfig
  var network: NetworkInterface

  lazy internal var usage: UsageReporter = { return Usage(api: self) }()

  init(config: APIConfig = APIConfig(), network: NetworkInterface = Network()) {
    self.config = config
    self.network = network
    self.network.reporter = self
  }

  func fruit(_ completion: @escaping ((GroceryResult) -> ())) {
    let request = FruitRequest(config: config).create()

    network.run(request) { response in
      completion(FruitResponse.handle(response))
    }
  }

  func track(_ report: UsageReport, _ completion: ((UsageReportError?) -> ())?) {
    let request = UsageReportRequest(config: config, report: report).create()

    network.run(request) { response in
      completion?(UsageReportResponse.handle(response))
    }
  }
}

extension API: NetworkReporter {
  func report(_ response: NetworkResponse) {
    let report = CreateReport.with(response)

    usage.register(report, completion: nil)
  }
}

fileprivate class CreateReport {
  class func with(_ response: NetworkResponse) -> UsageReport {
    return UsageReport(
      name: .load, data: [
        "data": "\(response.data?.count ?? 0)",
        "duration": "\(response.duration)"
      ]
    )
  }
}
