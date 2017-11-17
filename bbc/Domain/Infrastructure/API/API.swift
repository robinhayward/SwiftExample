//
//  API.swift
//  bbc
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

class API {
  static let shared: API = API(config: APIConfig(), session: URLSession.shared)

  let config: APIConfig
  let session: URLSession

  let log: Log = Log(enabled: true)

  init(config: APIConfig, session: URLSession) {
    self.config = config
    self.session = session
  }

  func run(_ request: URLRequest, _ completion: @escaping ((APIResponse) -> ())) {
    log.request(request)
    let sent = Date.timeIntervalSinceReferenceDate
    let task = session.dataTask(with: request) { [weak self] (data, response, error) in
      let duration = Date.timeIntervalSinceReferenceDate - sent
      let result = APIResponse(data, response, error, duration)
      self?.handle(result, with: completion)
    }

    task.resume()
  }

  // MARK: - Private

  private func handle(_ response: APIResponse, with completion: @escaping ((APIResponse) -> ())) {
    log.response(response)
    SwitchToMainThread.with {
      completion(response)
    }
  }
}

extension API {
  struct Log {
    var enabled: Bool

    func request(_ request: URLRequest) {
      guard enabled else { return }
      print("URL: \(request.url ?? URL(string: "http://url_not_set.com")!)")
      print("Method: \(request.httpMethod ?? "Not Set")")
    }

    func response(_ response: APIResponse) {
      guard enabled else { return }
      print("Response: \(response)")
    }
  }
}
