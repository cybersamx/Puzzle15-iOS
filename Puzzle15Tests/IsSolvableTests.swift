//
//  IsSolvableTests.swift
//  Puzzle15Tests
//
//  Created by Samuel Chow on 7/28/18.
//  Copyright © 2018 Samuel Chow. All rights reserved.
//

import XCTest
@testable import Puzzle15

class IsSolvableTests: XCTestCase {
  static let tileIcon = UIImage(named: "Logo-iOS")
  var tilesManager: TilesManager!

  override func setUp() {
    super.setUp()

    tilesManager = TilesManager(count: 16)
    tilesManager.loadAndSliceImage(image: UIImage(named: "Pic-SanFrancisco")!)
  }

  override func tearDown() {
    tilesManager = nil
    super.tearDown()
  }

  func testIsSolvableUsingSequentialSet() {
    var tiles: [Tile] = []

    for i in 0...14 {
      tiles.append(Tile(index: i, image: IsSolvableTests.tileIcon!))
    }
    tiles.append(Tile(index: 15))   // No image => empty tile

    XCTAssert(TilesManager.isSolvable(tiles: tiles), "Solvable using sequential tiles set")
  }

  func testIsSolvableUsingSolution1() {
    var tiles: [Tile] = []

    // Known solutions taken from: https://www.geeksforgeeks.org/check-instance-15-puzzle-solvable/
    tiles.append(Tile(index: 12, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 1, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 9, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 2, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 0, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 11, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 7, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 3, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 4, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 15))   // No image => empty tile
    tiles.append(Tile(index: 8, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 5, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 14, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 13, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 10, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 6, image: IsSolvableTests.tileIcon!))

    XCTAssert(TilesManager.isSolvable(tiles: tiles), "Solvable using solution 1")
  }

  func testIsSolvableUsingSolution2() {
    var tiles: [Tile] = []

    // Known solutions taken from: https://www.geeksforgeeks.org/check-instance-15-puzzle-solvable/
    tiles.append(Tile(index: 5, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 12, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 6, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 9, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 7, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 8, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 10, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 15))   // No image => empty tile
    tiles.append(Tile(index: 14, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 1, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 11, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 4, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 13, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 2, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 0, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 3, image: IsSolvableTests.tileIcon!))

    XCTAssert(TilesManager.isSolvable(tiles: tiles), "Solvable using solution 2")
  }

  func testIsSolvableUsingUnsolvableTiles() {
    var tiles: [Tile] = []

    // Known unsolvable solutions taken from: https://www.geeksforgeeks.org/check-instance-15-puzzle-solvable/
    tiles.append(Tile(index: 2, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 8, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 0, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 14, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 13, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 10, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 3, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 5, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 12, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 15))   // No image => empty tile
    tiles.append(Tile(index: 9, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 11, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 1, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 6, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 7, image: IsSolvableTests.tileIcon!))
    tiles.append(Tile(index: 4, image: IsSolvableTests.tileIcon!))

    XCTAssertFalse(TilesManager.isSolvable(tiles: tiles), "Not solvable")
  }

  func testIsSolvable() {
    XCTAssert(TilesManager.isSolvable(tiles: tilesManager.tiles), "TilesManager will always return a solvable set")
  }
}
