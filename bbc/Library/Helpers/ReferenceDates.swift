//
//  ReferenceDates.swift
//  bbc
//
//  Created by Robin Hayward on 20/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

class ReferenceDates {
  private var store: [String: Date] = [String: Date]()

  func checkIn(_ reference: String) {
    store[reference] = Date()
  }

  func checkOut(_ reference: String) -> Date {
    return store[reference] ?? Date()
  }
}
