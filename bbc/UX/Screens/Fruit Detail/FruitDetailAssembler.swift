//
//  FruitDetailAssembler.swift
//  bbc
//
//  Created by Robin Hayward on 15/11/2017.
//Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import UIKit

struct FruitDetailAssembly {
  var wireframe: FruitDetailWireframe
  var fruit: Fruit
  var usage: UsageReporter
}

class FruitDetailAssembler {
  class func assemble(assembly: FruitDetailAssembly) -> UIViewController {
    let interactor = FruitDetailInteractor(assembly.fruit, usage: assembly.usage)
    let presenter = FruitDetailPresenter(assembly.wireframe)
    let view = FruitDetailView(presenter)

    interactor.output = presenter

    presenter.interactor = interactor
    presenter.ui = view

    return view
  }
}
