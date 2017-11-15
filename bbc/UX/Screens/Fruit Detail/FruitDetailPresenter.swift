//
//  FruitDetailPresenter.swift
//  bbc
//
//  Created by Robin Hayward on 15/11/2017.
//Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import UIKit

class FruitDetailPresenter: FruitDetailUser, FruitDetailInteractorOutput {
  let wireframe: FruitDetailWireframe
  var interactor: FruitDetailInteractorInput?
  weak var ui: FruitDetailUI?

  init(_ wireframe: FruitDetailWireframe) {
    self.wireframe = wireframe
  }

  // MARK: FruitDetailUserActor

  func arrive() {
    interactor?.welcome()
  }

  // MARK: FruitDetailInteractorOutput

  func update(_ fruit: Fruit) {
    ui?.update(fruit)
  }
}
