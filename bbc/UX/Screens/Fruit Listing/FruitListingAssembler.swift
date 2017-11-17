//
//  FruitListingAssembler.swift
//  bbc
//
//  Created by Robin Hayward on 15/11/2017.
//Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import UIKit

class FruitListingAssembler {
  class func assemble(with wireframe: FruitListingWireframe, usage: UsageReporter = Usage()) -> UIViewController {
    let grocery = Grocery()
    let interactor = FruitListingInteractor(grocery, usage: usage)
    let presenter = FruitListingPresenter(wireframe)
    let view = FruitListingView(presenter)

    interactor.output = presenter

    presenter.interactor = interactor
    presenter.ui = view

    return view
  }

  class func assembleWithinNavigationController(with wireframe: FruitListingWireframe) -> UINavigationController {
    let view = assemble(with: wireframe)

    return UINavigationController(rootViewController: view)
  }
}
