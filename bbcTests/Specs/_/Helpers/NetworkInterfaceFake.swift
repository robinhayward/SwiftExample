//
//  NetworkInterfaceFake.swift
//  bbcTests
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

@testable import bbc

class NetworkFake: NetworkInterface {
  var reporter: NetworkReporter?
  var request: NetworkRequest?
  var completion: ((NetworkResponse) -> ())?

  func run(_ request: NetworkRequest, _ completion: @escaping ((NetworkResponse) -> ())) {
    self.request = request
    self.completion = completion
  }

  func completeLastRequest(with response: NetworkResponse) {
    guard let completion = completion else { return }

    reporter?.report(response)
    completion(response)
  }
}
