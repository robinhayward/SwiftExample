//
//  APISpec.swift
//  bbcTests
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import bbc

class APISpec: QuickSpec {
  override func spec() {
    var sut: API!
    var network: NetworkFake!

    describe("API") {
      beforeEach {
        network = NetworkFake()
        sut = API(network: network)
      }

    }
  }
}

