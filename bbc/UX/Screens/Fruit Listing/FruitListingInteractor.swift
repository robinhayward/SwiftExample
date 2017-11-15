//
//  FruitListingInteractor.swift
//  bbc
//
//  Created by Robin Hayward on 15/11/2017.
//Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import UIKit

class FruitListingInteractor: FruitListingInteractorInput {
  weak var output: FruitListingInteractorOutput?

  let service: GroceryAssistant

  init(_ service: GroceryAssistant) {
    self.service = service
  }

  func refresh() {
    service.fruit { [weak self] (result) in
      switch result {
      case .success(let fruit):
        self?.output?.hasListingUpdate(fruit: fruit)
      case .failure(let error):
        self?.output?.hasListingUpdate(error: error)
      }
    }
  }
}
