//
//  API.swift
//  bbc
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

protocol NetworkInterface {
  weak var reporter: NetworkReporter? { get set }

  func run(_ request: URLRequest, _ completion: @escaping ((NetworkResponse) -> ()))
}

protocol NetworkReporter: class {
  func report(_ response: NetworkResponse)
}

class Network: NetworkInterface {
  let session: URLSession

  weak var reporter: NetworkReporter?

  let log: Log = Log(enabled: true)

  init(session: URLSession = URLSession.shared) {
    self.session = session
  }

  func run(_ request: URLRequest, _ completion: @escaping ((NetworkResponse) -> ())) {
    log.request(request)
    let sent = Date.timeIntervalSinceReferenceDate
    let task = session.dataTask(with: request) { [weak self] (data, response, error) in
      let duration = Date.timeIntervalSinceReferenceDate - sent
      let result = NetworkResponse(data, response, error, duration)
      self?.handle(result, with: completion)
    }

    task.resume()
  }

  // MARK: - Private

  private func handle(_ response: NetworkResponse, with completion: @escaping ((NetworkResponse) -> ())) {
    SwitchToMainThread.with { [weak self] in
      self?.report(response)
      completion(response)
    }
  }

  private func report(_ response: NetworkResponse) {
    log.response(response)
    reporter?.report(response)
  }
}

extension Network {
  struct Log {
    var enabled: Bool

    func request(_ request: URLRequest) {
      guard enabled else { return }
      print("URL: \(request.url ?? URL(string: "http://url_not_set.com")!)")
      print("Method: \(request.httpMethod ?? "Not Set")")
    }

    func response(_ response: NetworkResponse) {
      guard enabled else { return }
      print("Response: \(response)")
    }
  }
}
