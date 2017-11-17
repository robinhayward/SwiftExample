//
//  main.swift
//  bbc
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import UIKit

class AppStub: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
}

func delegateClassName() -> String? {
  return NSClassFromString("XCTestCase") == nil ? NSStringFromClass(App.self) :  NSStringFromClass(AppStub.self)
}

UIApplicationMain(CommandLine.argc, UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc)), nil, delegateClassName())
