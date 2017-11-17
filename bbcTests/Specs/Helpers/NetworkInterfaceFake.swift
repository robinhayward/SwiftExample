//
//  NetworkInterfaceFake.swift
//  bbcTests
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

@testable import bbc

class APIInterfaceFake: APIInterface {
  let config: APIConfig = APIConfig()
  var request: URLRequest?
  var completion: ((APIResponse) -> ())?

  func run(_ request: URLRequest, _ completion: @escaping ((APIResponse) -> ())) {
    self.request = request
    self.completion = completion
  }
}
