//
//  SupermarketFake.swift
//  bbc
//
//  Created by Robin Hayward on 20/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

class SupermarketFake: Supermarket {
  func grocer() -> GroceryAssistant {
    return GroceryAssistantStub()
  }

  func reporter() -> UsageReporter {
    return UsageReporterStub()
  }
}

class GroceryAssistantStub: GroceryAssistant {
  func fruit(completion: @escaping (GroceryResult) -> ()) {
    completion(GroceryResult(.requestFailed))
  }
}

class UsageReporterStub: UsageReporter {
  func register(_ report: UsageReport, completion: ((UsageReportError?) -> ())?) {
    // UI Testing, do nothing.
  }
}
