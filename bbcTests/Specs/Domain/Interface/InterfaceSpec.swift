//
//  InterfaceSpec.swift
//  bbcTests
//
//  Created by Robin Hayward on 20/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Quick
import Nimble

@testable import bbc

class InterfaceSpec: QuickSpec {
  override func spec() {
    describe("interface") {
      describe("grocer") {
        it("returns a unique instance") {
          let sut = SupermarketSDK()
          let g1: AnyObject = sut.grocer()
          let g2: AnyObject = sut.grocer()

          expect(ObjectIdentifier(g1)).toNot(equal(ObjectIdentifier(g2)))
        }
      }
      describe("reporter") {
        it("returns a single instance") {
          let sut = SupermarketSDK()
          let u1: AnyObject = sut.reporter()
          let u2: AnyObject = sut.reporter()

          expect(ObjectIdentifier(u1)).to(equal(ObjectIdentifier(u2)))
        }
      }
    }
  }
}
