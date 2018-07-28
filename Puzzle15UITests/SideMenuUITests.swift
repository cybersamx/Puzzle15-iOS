//
//  SideMenuUITests.swift
//  Puzzle15UITests
//
//  Created by Samuel Chow on 7/20/18.
//  Copyright © 2018 Samuel Chow. All rights reserved.
//

import XCTest

class SideMenuUITests: XCTestCase {
  var app: XCUIApplication!

  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    XCUIApplication().launch()

    app = XCUIApplication()
  }

  override func tearDown() {
    super.tearDown()
  }

  func testAboutDialog() {
    // Side menu shouldn't exist.
    var sideMenuTable = app.tables["SideMenuTable"]
    XCTAssertFalse(sideMenuTable.exists, "Side menu doesn't exist")
    let menuButton = app.navigationBars["Puzzle15"].buttons["Menu"]

    // Tap the menu button should launch the side menu.
    menuButton.tap()
    sideMenuTable = app.tables["SideMenuTable"]
    XCTAssert(sideMenuTable.exists, "Side menu exists")

    // Tap the about cell should launch the about dialog.
    let about = sideMenuTable.staticTexts["About"]
    XCTAssert(about.exists, "About exists")
    about.tap()
    let dialog = app.alerts["About"]
    XCTAssert(dialog.exists, "About dialog exists")
    app.buttons["OK"].tap()
    XCTAssertFalse(dialog.exists, "About dialog doesn't exist")
  }
}

