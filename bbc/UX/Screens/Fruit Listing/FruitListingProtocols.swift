//
//  FruitListingProtocols.swift
//  bbc
//
//  Created by Robin Hayward on 15/11/2017.
//Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import UIKit

protocol FruitListingWireframe: class {
  func fruitListingSelected(_ fruit: Fruit)
}

protocol FruitListingUser: class {
  func arrived()
  func refresh()
  func select(_ fruit: Fruit)
}

protocol FruitListingUI: class {
  func loading()
  func updateListing(_ fruit: [Fruit])
  func updateListingFailure(_ error: GroceryError)
}

protocol FruitListingInteractorInput: class {
  func userArrived()
  func refresh()
}

protocol FruitListingInteractorOutput: class {
  func hasListingUpdate(fruit: [Fruit])
  func hasListingUpdate(error: GroceryError)
}
