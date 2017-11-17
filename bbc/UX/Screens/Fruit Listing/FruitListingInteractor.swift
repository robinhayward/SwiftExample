//
//  FruitListingInteractor.swift
//  bbc
//
//  Created by Robin Hayward on 15/11/2017.
//Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import UIKit

class FruitListingInteractor: FruitListingInteractorInput {
  weak var output: FruitListingInteractorOutput?

  let service: GroceryAssistant
  let usage: UsageReporter

  init(_ service: GroceryAssistant, usage: UsageReporter) {
    self.service = service
    self.usage = usage
  }

  func userArrived() {
    report()
    refresh()
  }

  func refresh() {
    service.fruit { [weak self] (result) in
      switch result {
      case .success(let fruit):
        self?.output?.hasListingUpdate(fruit: fruit)
      case .failure(let error):
        self?.output?.hasListingUpdate(error: error)
      }
    }
  }

  private func report() {
    let event = UsageReport(
      name: .display,
      data: [
        "screen": "fruit-listings"
      ]
    )

    usage.register(event, completion: nil)
  }
}
