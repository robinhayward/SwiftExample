//
//  FruitDetailAssembler.swift
//  bbc
//
//  Created by Robin Hayward on 15/11/2017.
//Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import UIKit

class FruitDetailAssembler {
  class func assemble(with wireframe: FruitDetailWireframe, fruit: Fruit) -> UIViewController {
    let interactor = FruitDetailInteractor(fruit)
    let presenter = FruitDetailPresenter(wireframe)
    let view = FruitDetailView(presenter)

    interactor.output = presenter

    presenter.interactor = interactor
    presenter.ui = view

    return view
  }
}
