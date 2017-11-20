//
//  ErrorPath.swift
//  bbcUITests
//
//  Created by Robin Hayward on 20/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import XCTest

class ErrorPath: XCTestCase {
  var app: XCUIApplication!
  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    app = XCUIApplication()
    app.launchArguments = ["UITestingErrorPath"]
    app.launch()
  }

  override func tearDown() {
    super.tearDown()
  }

  func testApplicationWalkThrough() {
    let app = XCUIApplication()
    app.staticTexts["Oh no, something went wrong"].tap()
    app.buttons["Retry"].tap()
  }
}
