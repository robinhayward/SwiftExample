//
//  FruitListingAssembler.swift
//  bbc
//
//  Created by Robin Hayward on 15/11/2017.
//Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import UIKit

struct FruitListingAssembly {
  var wireframe: FruitListingWireframe
  var grocery: GroceryAssistant
  var usage: UsageReporter
}

class FruitListingAssembler {
  class func assemble(assembly: FruitListingAssembly) -> UIViewController {
    let interactor = FruitListingInteractor(assembly.grocery, usage: assembly.usage)
    let presenter = FruitListingPresenter(assembly.wireframe)
    let view = FruitListingView(presenter)

    interactor.output = presenter

    presenter.interactor = interactor
    presenter.ui = view

    return view
  }

  class func assembleWithinNavigationController(assembly: FruitListingAssembly) -> UINavigationController {
    let view = assemble(assembly: assembly)

    return UINavigationController(rootViewController: view)
  }
}
