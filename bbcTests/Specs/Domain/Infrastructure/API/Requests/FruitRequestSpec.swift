//
//  FruitRequest.swift
//  bbcTests
//
//  Created by Robin Hayward on 20/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import bbc

class FruitRequestSpec: QuickSpec {
  override func spec() {
    var sut: FruitRequest!
    let config = APIConfig()

    describe("Fruit request") {
      describe("create") {
        beforeEach {
          sut = FruitRequest(config: config)
        }

        it("returns a valid request") {
          let request = sut.create()
          expect(request).toNot(beNil())
          expect(request.urlRequest.url?.absoluteString).to(equal("https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/data.json"))
          expect(request.urlRequest.httpMethod).to(equal("GET"))
        }
      }
    }
  }
}
