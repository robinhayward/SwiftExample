//
//  FruitDetailAssembler.swift
//  bbc
//
//  Created by Robin Hayward on 15/11/2017.
//Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import UIKit

protocol FruitDetailAssembly {
  var wireframe: FruitDetailWireframe { get set }
  var fruit: Fruit { get set }
  var usage: UsageReporter { get set }
}

struct FruitDetailAssemblyDefault: FruitDetailAssembly {
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
