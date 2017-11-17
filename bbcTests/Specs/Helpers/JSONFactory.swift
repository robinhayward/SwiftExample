//
//  JSONFactory.swift
//  bbcTests
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

class JSONFactory {
  class func fruit() -> Data {
    let json = [
      "fruit": [
        ["type":"apple", "price": 149, "weight": 120],
        ["type":"pear", "price": 129, "weight": 80],
      ]
    ]

    return try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
  }

  class func bad() -> Data {
    return Data()
  }
}
