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

}

protocol FruitDetailUser: class {
  func arrive()
}

protocol FruitDetailUI: class {
  func update(_ fruit: Fruit)
}

protocol FruitDetailInteractorInput: class {
  func welcome()
}

protocol FruitDetailInteractorOutput: class {
  func update(_ fruit: Fruit)
}
