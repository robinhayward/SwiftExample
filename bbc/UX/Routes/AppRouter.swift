//
//  AppRouter.swift
//  bbc
//
//  Created by Robin Hayward on 15/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import UIKit

class AppRouter {
  let window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
  let factory: AppRouterFactory

  private var root: UINavigationController?

  init(factory: AppRouterFactory = AppRouterFactory()) {
    self.factory = factory
  }

  func start() -> UIWindow {
    root = factory.listings(wireframe: self)
    window.rootViewController = root
    window.makeKeyAndVisible()

    return window
  }
}

extension AppRouter: FruitListingWireframe {
  func fruitListingSelected(_ fruit: Fruit) {
    let view = factory.detail(wireframe: self, fruit: fruit)

    root?.present(view, animated: true)
  }
}

extension AppRouter: FruitDetailWireframe {
  func fruitDetailDone() {
    root?.dismiss(animated: true)
  }
}

// MARK: - Factory

class AppRouterFactory {
  func listings(wireframe: FruitListingWireframe) -> UINavigationController {
    return FruitListingAssembler.assembleWithinNavigationController(with: wireframe)
  }

  func detail(wireframe: FruitDetailWireframe, fruit: Fruit) -> UIViewController {
    return FruitDetailAssembler.assemble(with: wireframe, fruit: fruit, usage: Usage())
  }
}
