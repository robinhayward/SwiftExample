//
//  ReferenceDatesSpec.swift
//  bbcTests
//
//  Created by Robin Hayward on 20/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Quick
import Nimble

@testable import bbc

class ReferenceDatesSpec: QuickSpec {
  override func spec() {
    describe("Reference dates") {
      var sut: ReferenceDates!
      var dateProvider: DateProviderFake!

      beforeEach {
        dateProvider = DateProviderFake()
        sut = ReferenceDates()
        sut.dateProvider = dateProvider
      }

      describe("check in, check out") {
        context("with a known reference") {
          let checkInDate = Date()
          beforeEach {
            dateProvider.simulatedDate = checkInDate
            sut.checkIn("hello")
          }

          it("returns the date it is was checked in") {
            let date = sut.checkOut("hello")

            expect(date).to(equal(checkInDate))
          }
        }

        context("without a known reference") {
          it("returns the current date") {
            let date = sut.checkOut("hello")

            expect(date).to(equal(dateProvider.simulatedDate))
          }
        }
      }
    }
  }
}

class DateProviderFake: DateProvider {
  var simulatedDate: Date = Date()

  override func now() -> Date {
    return simulatedDate
  }
}
