//
//  Fruit.swift
//  bbc
//
//  Created by Robin Hayward on 15/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

public struct Fruit: Codable {
  let type: String
  let price: Int
  let weight: Int
}

public struct FruitViewModel {
  let model: Fruit

  var displayName: String { return model.type.capitalized }
  var formattedPrice: String { return "\(model.price)" }
  var formattedWeight: String { return "\(model.weight)" }
}
