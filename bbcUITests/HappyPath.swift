//
//  HappyPath.swift
//  bbcUITests
//
//  Created by Robin Hayward on 20/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import XCTest

class HappyPath: XCTestCase {
  var app: XCUIApplication!
  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    app = XCUIApplication()
    app.launchArguments = ["UITestingHappyPath"]
    app.launch()
  }

  override func tearDown() {
    super.tearDown()
  }

  func testApplicationWalkThrough() {
    let tablesQuery = app.tables
    tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Apple"]/*[[".cells.staticTexts[\"Apple\"]",".staticTexts[\"Apple\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    app.staticTexts["Apple"].tap()

    let doneButton = app.buttons["DONE"]
    doneButton.tap()
    tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Kumquat"]/*[[".cells.staticTexts[\"Kumquat\"]",".staticTexts[\"Kumquat\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    doneButton.tap()
  }
}
