//
//  APIConfig.swift
//  bbc
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

class APIConfig {
  let host: String

  init(host: String = "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master") {
    self.host = host
  }
}
