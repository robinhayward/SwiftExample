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

  private let referenceDate: ReferenceDates = ReferenceDates()

  private struct ReferenceDateEvent {
    static let display = "display"
  }
  
  init(_ service: GroceryAssistant, usage: UsageReporter) {
    self.service = service
    self.usage = usage
  }

  func userArrived() {
    refresh()
  }

  func refresh() {
    referenceDate.checkIn(ReferenceDateEvent.display)
    service.fruit { [weak self] (result) in
      switch result {
      case .success(let fruit):
        self?.output?.hasListingUpdate(fruit: fruit)
      case .failure(let error):
        self?.output?.hasListingUpdate(error: error)
        self?.sendErrorReport(error)
      }
      self?.sendDisplayReport()
    }
  }

  // MARK: - Private

  private func sendErrorReport(_ error: GroceryError) {
    let report = UsageReport(name: .error, data: [
        "data": error.description(),
        "file": "\(Macro.filename(from: #file))",
        "line": "\(#line)"
      ]
    )

    usage.register(report, completion: nil)
  }

  private func sendDisplayReport() {
    let since = referenceDate.checkOut(ReferenceDateEvent.display)
    let report = createDisplayReport(referenceDate: since)

    usage.register(report, completion: nil)
  }

  private func createDisplayReport(referenceDate: Date) -> UsageReport {
    let duration = Date.timeIntervalSinceReferenceDate - referenceDate.timeIntervalSinceReferenceDate
    return UsageReport(
      name: .display,
      data: [
        "screen": "fruit-listings",
        "duration": "\(duration)"
      ]
    )
  }
}
