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
  class func fruit() -> APIResponse {
    return APIResponse(JSONFactory.fruit(), HTTPURLResponseFactory.good(), nil, 0.7)
  }

  class func badFruit() -> APIResponse {
    return APIResponse(JSONFactory.bad(), HTTPURLResponseFactory.good(), nil, 0.7)
  }

  class func serverError() -> APIResponse {
    return APIResponse(nil, HTTPURLResponseFactory.status(code: 500), nil, 0.1)
  }
}
