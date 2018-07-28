//
//  TilesUITests.swift
//  Puzzle15UITests
//
//  Created by Samuel Chow on 7/28/18.
//  Copyright © 2018 Samuel Chow. All rights reserved.
//

import XCTest

class TilesUITests: XCTestCase {
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

  private func getCellByAccessibilityIdentifier(_ index: Int) -> (XCUIElement) {
    let cellsQuery = app.collectionViews.children(matching: .cell)
    return cellsQuery.matching(NSPredicate(format: "identifier == 'ImageCell-\(index)'")).element
  }

  private func getCellByIndex(_ index: Int) -> (XCUIElement) {
    let cellsQuery = app.collectionViews.children(matching: .cell)
    return cellsQuery.element(boundBy: index)
  }

  func testAllTileCellsExist() {
    // All 16 tiles exist.
    for i in 0..<15 {
      XCTAssert(getCellByIndex(i).exists, "Tile cell \(i)exists")
    }
  }

  func testMoveCell() {
    // Tap the last visible cell to move it to the empty cell.
    getCellByAccessibilityIdentifier(14).tap()

    // The empty cell and the apped cell should swap.
    let cellWithIdentifier15 = getCellByAccessibilityIdentifier(15)
    let cellWithIdentifier14 = getCellByAccessibilityIdentifier(14)
    let cellAt15 = getCellByIndex(15)
    let cellAt14 = getCellByIndex(14)
    XCTAssert(cellAt14.identifier == cellWithIdentifier15.identifier, "Tile 14 swapped")
    XCTAssert(cellAt15.identifier == cellWithIdentifier14.identifier, "Tile 15 swapped")
  }

  func testPuzzleComplete() {
    // Tap the cell twice will return the cell back to its original position (for a non-shuffled tiles set).
    getCellByAccessibilityIdentifier(14).tap()
    getCellByAccessibilityIdentifier(14).tap()

    // Test for the complete dialog.
    let dialog = app.alerts["Congratulations"]
    XCTAssert(dialog.exists, "Complete dialog exists")
    app.buttons["Replay"].tap()
    XCTAssertFalse(dialog.exists, "About complete doesn't exist")
  }
}

