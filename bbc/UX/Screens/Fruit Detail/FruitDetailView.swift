//
//  FruitDetailView.swift
//  bbc
//
//  Created by Robin Hayward on 15/11/2017.
//Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import UIKit

class FruitDetailView: UIViewController, FruitDetailUI {
  let presenter: FruitDetailPresenter
  let user: FruitDetailUser

  init(_ presenter: FruitDetailPresenter) {
    self.presenter = presenter
    self.user = presenter
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    user.arrive()
  }

  // MARK: FruitDetailUI

  func update(_ fruit: Fruit) {
    title = fruit.type
  }
}
