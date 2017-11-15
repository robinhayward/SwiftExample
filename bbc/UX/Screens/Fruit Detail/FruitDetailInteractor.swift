//
//  FruitDetailInteractor.swift
//  bbc
//
//  Created by Robin Hayward on 15/11/2017.
//Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import UIKit

class FruitDetailInteractor: FruitDetailInteractorInput {
  weak var output: FruitDetailInteractorOutput?

  let entity: Fruit

  init(_ entity: Fruit) {
    self.entity = entity
  }

  func welcome() {
    output?.update(entity)
  }
}
