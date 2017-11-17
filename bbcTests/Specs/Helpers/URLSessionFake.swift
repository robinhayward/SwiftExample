//
//  URLSessionFake.swift
//  bbcTests
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

class URLSessionFake: URLSession {
  var request: URLRequest?
  var requestCompletionHandler: ((Data?, URLResponse?, Error?) -> ())?
  var requestInProgress: URLSessionDataTaskFake?

  func reset() {
    request = nil
    requestInProgress = nil
    requestCompletionHandler = nil
  }

  override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
    self.request = request
    self.requestCompletionHandler = completionHandler

    let task = URLSessionDataTaskFake()
    task.simulatedOriginalRequest = request

    requestInProgress = task

    return task
  }

  override func getAllTasks(completionHandler: @escaping ([URLSessionTask]) -> Void) {
    var tasks = [URLSessionDataTaskFake]()
    if let current = requestInProgress {
      tasks.append(current)
    }
    completionHandler(tasks)
  }
}

class URLSessionDataTaskFake: URLSessionDataTask {
  var resumed: Bool = false
  var cancelled: Bool = false

  var simulatedOriginalRequest: URLRequest?
  override var originalRequest: URLRequest? { return simulatedOriginalRequest }

  override func resume() {
    resumed = true
  }

  override func cancel() {
    cancelled = true
  }
}

class HTTPURLResponseFactory {
  class func good() -> HTTPURLResponse {
    return HTTPURLResponse(url: URL(string: "http://tests.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
  }
  class func status(code: Int) -> HTTPURLResponse {
    return HTTPURLResponse(url: URL(string: "http://tests.com")!, statusCode: code, httpVersion: nil, headerFields: nil)!
  }
  class func serverError() -> HTTPURLResponse {
    return HTTPURLResponse(url: URL(string: "http://tests.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
  }
}
