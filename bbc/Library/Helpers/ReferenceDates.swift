//
//  ReferenceDates.swift
//  bbc
//
//  Created by Robin Hayward on 20/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

class DateProvider {
  func now() -> Date {
    return Date()
  }
}
class ReferenceDates {
  private var store: [String: Date] = [String: Date]()

  internal var dateProvider: DateProvider = DateProvider()

  func checkIn(_ reference: String) {
    store[reference] = dateProvider.now()
  }

  func checkOut(_ reference: String) -> Date {
    let date = store[reference] ?? dateProvider.now()

    store[reference] = nil

    return date
  }
}
