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

  func run(_ request: NetworkRequest, _ completion: @escaping ((NetworkResponse) -> ()))
}

protocol NetworkReporter: class {
  func report(_ response: NetworkResponse)
}

struct NetworkRequest {
  let urlRequest: URLRequest
  let report: Bool
}

class Network: NetworkInterface {
  let session: URLSession

  weak var reporter: NetworkReporter?

  let log: Log = Log(enabled: true)

  init(session: URLSession = URLSession.shared) {
    self.session = session
  }

  func run(_ request: NetworkRequest, _ completion: @escaping ((NetworkResponse) -> ())) {
    log.request(request)
    let sent = Date.timeIntervalSinceReferenceDate
    let task = session.dataTask(with: request.urlRequest) { [weak self] (data, response, error) in
      let duration = Date.timeIntervalSinceReferenceDate - sent
      let result = NetworkResponse(data, response, error, duration, reportable: request.report)
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

    guard response.reportable else { return }

    reporter?.report(response)
  }
}

extension Network {
  struct Log {
    var enabled: Bool

    func request(_ request: NetworkRequest) {
      guard enabled else { return }
      print("URL: \(request.urlRequest.url ?? URL(string: "http://url_not_set.com")!)")
      print("Method: \(request.urlRequest.httpMethod ?? "Not Set")")
    }

    func response(_ response: NetworkResponse) {
      guard enabled else { return }
      print("Response: \(response)")
    }
  }
}
