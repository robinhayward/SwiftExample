//
//  API.swift
//  bbc
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

protocol APIInterface {
  func fruit(completion: @escaping (APIResponse) -> ())
  func send(_ report: UsageReport)
}

class API: APIInterface {
  let config: APIConfig
  let session: URLSession

  init(config: APIConfig = APIConfig(), session: URLSession = URLSession.shared) {
    self.config = config
    self.session = session
  }

  func fruit(completion: @escaping (APIResponse) -> ()) {
    let url = URL(string: "\(config.host)/data.json")!
    let request = URLRequest(url: url)
    let task = session.dataTask(with: request) { (data, response, error) in
      SwitchToMainThread.with {
        completion(APIResponse(data, response, error))
      }
    }

    task.resume()
  }

  func send(_ report: UsageReport) {
    let resource = "\(config.host)/stats"
    let url = UsageReportUrl.create(resource: resource, report: report)
    let request = URLRequest(url: url)
    let task = session.dataTask(with: request) { (data, response, error) in
      SwitchToMainThread.with {
        debugPrint(APIResponse(data, response, error))
      }
    }

    task.resume()
  }
}
