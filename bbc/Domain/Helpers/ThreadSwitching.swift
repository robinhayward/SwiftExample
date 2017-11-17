//
//  Thread.swift
//  bbc
//
//  Created by Robin Hayward on 15/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

class SwitchToMainThread {
  class func with(_ block: @escaping (() -> ())) {
    guard Thread.isMainThread else {
      DispatchQueue.main.async {
        SwitchToMainThread.with(block)
      }
      return
    }

    block()
  }
}
