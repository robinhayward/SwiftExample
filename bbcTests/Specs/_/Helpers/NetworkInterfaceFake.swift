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
  var request: URLRequest?
  var completion: ((NetworkResponse) -> ())?

  func run(_ request: URLRequest, _ completion: @escaping ((NetworkResponse) -> ())) {
    self.request = request
    self.completion = completion
  }
}
