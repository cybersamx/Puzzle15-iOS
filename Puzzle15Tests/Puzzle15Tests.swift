//
//  Puzzle15Tests.swift
//  Puzzle15Tests
//
//  Created by Samuel Chow on 7/20/18.
//  Copyright © 2018 Samuel Chow. All rights reserved.
//

import XCTest
@testable import Puzzle15

class Puzzle15Tests: XCTestCase {
  static let tileIcon = UIImage(named: "Logo-iOS")

  let tilesManager: TilesManager = {
    let tilesManager = TilesManager(count: 16, countPerRow: 4)
    tilesManager.loadAndSliceImage(image: UIImage(named: "Pic-SanFrancisco")!)

    return tilesManager
  }()

  override func setUp() {
    super.setUp()

  }

  override func tearDown() {
    super.tearDown()
  }

  func testIndicesAdjacentTo() {
    var indices = tilesManager.indicesAdjacentTo(index: 0)
    XCTAssert(indices[0] == 1, "index: 0")
    XCTAssert(indices[1] == 4, "index: 0")

    indices = tilesManager.indicesAdjacentTo(index: 1)
    XCTAssert(indices[0] == 0, "index: 1")
    XCTAssert(indices[1] == 2, "index: 1")
    XCTAssert(indices[2] == 5, "index: 1")

    indices = tilesManager.indicesAdjacentTo(index: 2)
    XCTAssert(indices[0] == 1, "index: 2")
    XCTAssert(indices[1] == 3, "index: 2")
    XCTAssert(indices[2] == 6, "index: 2")

    indices = tilesManager.indicesAdjacentTo(index: 3)
    XCTAssert(indices[0] == 2, "index: 3")
    XCTAssert(indices[1] == 7, "index: 3")

    indices = tilesManager.indicesAdjacentTo(index: 4)
    XCTAssert(indices[0] == 0, "index: 4")
    XCTAssert(indices[1] == 5, "index: 4")
    XCTAssert(indices[2] == 8, "index: 4")

    indices = tilesManager.indicesAdjacentTo(index: 5)
    XCTAssert(indices[0] == 4, "index: 5")
    XCTAssert(indices[1] == 1, "index: 5")
    XCTAssert(indices[2] == 6, "index: 5")
    XCTAssert(indices[3] == 9, "index: 5")

    indices = tilesManager.indicesAdjacentTo(index: 6)
    XCTAssert(indices[0] == 5, "index: 6")
    XCTAssert(indices[1] == 2, "index: 6")
    XCTAssert(indices[2] == 7, "index: 6")
    XCTAssert(indices[3] == 10, "index: 6")

    indices = tilesManager.indicesAdjacentTo(index: 7)
    XCTAssert(indices[0] == 6, "index: 7")
    XCTAssert(indices[1] == 3, "index: 7")
    XCTAssert(indices[2] == 11, "index: 7")

    indices = tilesManager.indicesAdjacentTo(index: 8)
    XCTAssert(indices[0] == 4, "index: 8")
    XCTAssert(indices[1] == 9, "index: 8")
    XCTAssert(indices[2] == 12, "index: 8")

    indices = tilesManager.indicesAdjacentTo(index: 9)
    XCTAssert(indices[0] == 8, "index: 9")
    XCTAssert(indices[1] == 5, "index: 9")
    XCTAssert(indices[2] == 10, "index: 9")
    XCTAssert(indices[3] == 13, "index: 9")

    indices = tilesManager.indicesAdjacentTo(index: 10)
    XCTAssert(indices[0] == 9, "index: 10")
    XCTAssert(indices[1] == 6, "index: 10")
    XCTAssert(indices[2] == 11, "index: 10")
    XCTAssert(indices[3] == 14, "index: 10")

    indices = tilesManager.indicesAdjacentTo(index: 11)
    XCTAssert(indices[0] == 10, "index: 11")
    XCTAssert(indices[1] == 7, "index: 11")
    XCTAssert(indices[2] == 15, "index: 11")

    indices = tilesManager.indicesAdjacentTo(index: 12)
    XCTAssert(indices[0] == 8, "index: 12")
    XCTAssert(indices[1] == 13, "index: 12")

    indices = tilesManager.indicesAdjacentTo(index: 13)
    XCTAssert(indices[0] == 12, "index: 13")
    XCTAssert(indices[1] == 9, "index: 13")
    XCTAssert(indices[2] == 14, "index: 13")

    indices = tilesManager.indicesAdjacentTo(index: 14)
    XCTAssert(indices[0] == 13, "index: 14")
    XCTAssert(indices[1] == 10, "index: 14")
    XCTAssert(indices[2] == 15, "index: 14")

    indices = tilesManager.indicesAdjacentTo(index: 15)
    XCTAssert(indices[0] == 14, "index: 15")
    XCTAssert(indices[1] == 11, "index: 15")
  }

  func testIsSolvableUsingSequentialSolution() {
    var tiles: [Tile] = []

    for i in 0...14 {
      tiles.append(Tile(index: i, image: Puzzle15Tests.tileIcon!))
    }
    tiles.append(Tile(index: 15))   // No image => empty tile

    XCTAssert(TilesManager.isSolvable(tiles: tiles), "Solvable using sequential tiles set")
  }

  func testIsSolvableUsingSolution1() {
    var tiles: [Tile] = []

    // Known solutions taken from: https://www.geeksforgeeks.org/check-instance-15-puzzle-solvable/
    tiles.append(Tile(index: 12, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 1, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 9, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 2, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 0, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 11, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 7, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 3, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 4, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 15))   // No image => empty tile
    tiles.append(Tile(index: 8, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 5, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 14, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 13, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 10, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 6, image: Puzzle15Tests.tileIcon!))

    XCTAssert(TilesManager.isSolvable(tiles: tiles), "Solvable using solution 1")
  }

  func testIsSolvableUsingSolution2() {
    var tiles: [Tile] = []

    // Known solutions taken from: https://www.geeksforgeeks.org/check-instance-15-puzzle-solvable/
    tiles.append(Tile(index: 5, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 12, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 6, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 9, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 7, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 8, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 10, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 15))   // No image => empty tile
    tiles.append(Tile(index: 14, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 1, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 11, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 4, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 13, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 2, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 0, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 3, image: Puzzle15Tests.tileIcon!))

    XCTAssert(TilesManager.isSolvable(tiles: tiles), "Solvable using solution 2")
  }

  func testIsSolvableUsingUnsolvableTiles() {
    var tiles: [Tile] = []

    // Known unsolvable solutions taken from: https://www.geeksforgeeks.org/check-instance-15-puzzle-solvable/
    tiles.append(Tile(index: 2, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 8, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 0, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 14, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 13, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 10, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 3, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 5, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 12, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 15))   // No image => empty tile
    tiles.append(Tile(index: 9, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 11, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 1, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 6, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 7, image: Puzzle15Tests.tileIcon!))
    tiles.append(Tile(index: 4, image: Puzzle15Tests.tileIcon!))

    XCTAssert(!TilesManager.isSolvable(tiles: tiles), "Not solvable")
  }

  func testIsSolvable() {
    XCTAssert(TilesManager.isSolvable(tiles: tilesManager.tiles), "TilesManager will always return a solvable set")
  }

  func testPerformanceExample() {
    self.measure {

    }
  }
}

