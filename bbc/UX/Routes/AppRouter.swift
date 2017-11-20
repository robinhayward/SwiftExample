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

  init(factory: AppRouterFactory = AppRouterFactory(sdk: SDKFactory.create())) {
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

class SDKFactory {
  class func create() -> Supermarket {
    let arguments = ProcessInfo.processInfo.arguments
    if  arguments.contains("UITestingErrorPath") {
      return SupermarketFake()
    }

    return SupermarketSDK()
  }
}

struct AppRouterFactory {
  let sdk: Supermarket

  func listings(wireframe: FruitListingWireframe) -> UINavigationController {
    let assembly = FruitListingAssembly(
      wireframe: wireframe,
      grocery: sdk.grocer(),
      usage: sdk.reporter()
    )
    
    return FruitListingAssembler.assembleWithinNavigationController(assembly: assembly)
  }

  func detail(wireframe: FruitDetailWireframe, fruit: Fruit) -> UIViewController {
    let assembly = FruitDetailAssembly(
      wireframe: wireframe,
      fruit: fruit,
      usage: sdk.reporter()

    )
    return FruitDetailAssembler.assemble(assembly: assembly)
  }
}
