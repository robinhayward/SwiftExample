//
//  FruitDetailInteractor.swift
//  bbc
//
//  Created by Robin Hayward on 15/11/2017.
//Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import UIKit

class FruitDetailInteractor: FruitDetailInteractorInput {
  weak var output: FruitDetailInteractorOutput?

  let entity: Fruit
  let usage: UsageReporter

  init(_ entity: Fruit, usage: UsageReporter) {
    self.entity = entity
    self.usage = usage
  }

  func welcome() {
    report()
    output?.update(entity)
  }

  private func report() {
    let event = UsageReport(
      name: .display,
      data: [
        "screen": "fruit-detail",
        "fruit-type": entity.type,
        "fruit-node": "a node 1"
      ]
    )

    usage.register(event, completion: nil)
  }
}
