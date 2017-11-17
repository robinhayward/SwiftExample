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

  private let loggingEnabled = true

  init(config: APIConfig = APIConfig(), session: URLSession = URLSession.shared) {
    self.config = config
    self.session = session
  }

  func fruit(completion: @escaping (APIResponse) -> ()) {
    let url = URL(string: "\(config.host)/data.json")!
    let request = URLRequest(url: url)
    let task = session.dataTask(with: request) { [weak self] (data, response, error) in
      SwitchToMainThread.with {
        let response = APIResponse(data, response, error)
        self?.log(request, response)
        completion(response)
      }
    }

    task.resume()
  }

  func send(_ report: UsageReport) {
    let resource = "\(config.host)/stats"

    guard
      let request = UsageReportUrlRequest(report, resource).create()
    else {
      debugPrint("Failed to register usage report for: \(report)")
      return
    }

    let task = session.dataTask(with: request) { [weak self] (data, response, error) in
      SwitchToMainThread.with {
        let response = APIResponse(data, response, error)
        self?.log(request, response)
      }
    }

    task.resume()
  }

  private func log(_ request: URLRequest, _ response: APIResponse) {
    guard loggingEnabled else { return }
    print("URL: \(request.url ?? URL(string: "http://url_not_set.com")!)")
    print("Method: \(request.httpMethod ?? "Not Set")")
    print("Response: \(response)")
  }
}
