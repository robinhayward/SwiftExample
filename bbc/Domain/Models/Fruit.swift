//
//  Fruit.swift
//  bbc
//
//  Created by Robin Hayward on 15/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

protocol Fruit {
  var uuid: String { get }
  var name: String { get }
}

struct FruitEntity: Fruit {
  let uuid: String
  let name: String
}
