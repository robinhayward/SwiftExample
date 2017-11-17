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

  func done() {
    wireframe.fruitDetailDone()
  }

  // MARK: FruitDetailInteractorOutput

  func update(_ fruit: Fruit) {
    let view = FruitViewModel(model: fruit)
    let content = FruitDetailViewContent(
      title: view.displayName,
      fruitName: view.displayName,
      priceTitle: "Price",
      priceValue: view.formattedPrice,
      weightTitle: "Weight",
      weightValue: view.formattedWeight,
      doneButtonTitle: "DONE"
    )
    
    ui?.update(content)
  }
}

struct FruitDetailViewContent {
  let title: String
  let fruitName: String
  let priceTitle: String
  let priceValue: String
  let weightTitle: String
  let weightValue: String
  let doneButtonTitle: String
}
