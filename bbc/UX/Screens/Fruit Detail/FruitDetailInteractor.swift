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

  private let referenceDate: ReferenceDates = ReferenceDates()

  private struct ReferenceDateEvent {
    static let display = "display"
  }

  init(_ entity: Fruit, usage: UsageReporter) {
    self.entity = entity
    self.usage = usage
  }

  func welcome() {
    referenceDate.checkIn(ReferenceDateEvent.display)
    output?.update(entity)
    sendDisplayReport()
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
        "screen": "fruit-detail",
        "fruit-type": entity.type,
        "duration": "\(duration)"
      ]
    )
  }
}
