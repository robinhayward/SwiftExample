//
//  NetworkResponseFactory.swift
//  bbcTests
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

@testable import bbc

class NetworkResponseFactory {
  class func statusTwoHundredNoDataExpected() -> NetworkResponse {
    return NetworkResponse(nil, HTTPURLResponseFactory.good(), nil, 0.7)
  }

  class func fruit() -> NetworkResponse {
    return NetworkResponse(JSONFactory.fruit(), HTTPURLResponseFactory.good(), nil, 0.7)
  }

  class func badFruit() -> NetworkResponse {
    return NetworkResponse(JSONFactory.bad(), HTTPURLResponseFactory.good(), nil, 0.7)
  }

  class func serverError() -> NetworkResponse {
    return NetworkResponse(nil, HTTPURLResponseFactory.status(code: 500), nil, 0.1)
  }
}
