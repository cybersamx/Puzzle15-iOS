//
//  AdjacentToTests.swift
//  Puzzle15Tests
//
//  Created by Samuel Chow on 7/28/18.
//  Copyright © 2018 Samuel Chow. All rights reserved.
//

import XCTest
@testable import Puzzle15

class AdjacentToTests: XCTestCase {
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
}

