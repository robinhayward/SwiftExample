//
//  FruitListingPresenter.swift
//  bbc
//
//  Created by Robin Hayward on 15/11/2017.
//Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import UIKit

class FruitListingPresenter: FruitListingUser, FruitListingInteractorOutput {
  let wireframe: FruitListingWireframe
  var interactor: FruitListingInteractorInput?
  weak var ui: FruitListingUI?

  init(_ wireframe: FruitListingWireframe) {
    self.wireframe = wireframe
  }

  // MARK: FruitListingUserActor

  func arrived() {
    ui?.loading()
    interactor?.userArrived()
  }

  func refresh() {
    ui?.loading()
    interactor?.refresh()
  }

  func select(_ fruit: Fruit) {
    wireframe.fruitListingSelected(fruit)
  }

  // MARK: FruitListingInteractorOutput

  func hasListingUpdate(fruit: [Fruit]) {
    ui?.finishLoading()
    fruit.count > 0 ? ui?.updateListing(fruit) : ui?.noFruitAvailable()
  }

  func hasListingUpdate(error: GroceryError) {
    ui?.finishLoading()
    ui?.updateListingFailure(error)
  }
}
