//
//  Result.swift
//  bbc
//
//  Created by Robin Hayward on 15/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

enum Result<T, U> {
  case success(T)
  case failure(U)

  init(_ data: T) {
    self = .success(data)
  }

  init(_ error: U) {
    self = .failure(error)
  }
}
