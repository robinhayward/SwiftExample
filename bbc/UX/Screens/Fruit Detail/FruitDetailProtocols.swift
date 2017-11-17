//
//  FruitDetailProtocols.swift
//  bbc
//
//  Created by Robin Hayward on 15/11/2017.
//Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import UIKit

protocol FruitDetailWireframe: class {
  func fruitDetailDone()
}

protocol FruitDetailUser: class {
  func arrive()
  func done()
}

protocol FruitDetailUI: class {
  func update(_ content: FruitDetailViewContent)
}

protocol FruitDetailInteractorInput: class {
  func welcome()
}

protocol FruitDetailInteractorOutput: class {
  func update(_ fruit: Fruit)
}
