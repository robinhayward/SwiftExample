//
//  FruitFactory.swift
//  bbcTests
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

@testable import bbc

class FruitFactory {
  class func apple() -> Fruit {
    return Fruit(type: "apple", price: 1, weight: 2)
  }

  class func pear() -> Fruit {
    return Fruit(type: "pear", price: 3, weight: 4)
  }

  class func lemon() -> Fruit {
    return Fruit(type: "lemon", price: 5, weight: 6)
  }

  class func two() -> [Fruit] {
    return [apple(), pear()]
  }

  class func three() -> [Fruit] {
    return [apple(), pear(), lemon()]
  }
}
