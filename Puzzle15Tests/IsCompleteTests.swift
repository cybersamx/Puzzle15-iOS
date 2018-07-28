//
//  IsCompleteTests.swift
//  Puzzle15Tests
//
//  Created by Samuel Chow on 7/28/18.
//  Copyright © 2018 Samuel Chow. All rights reserved.
//

import XCTest
@testable import Puzzle15

class IsCompleteTests: XCTestCase {
  var sequentialTilesManager: TilesManager!
  var shuffledTilesManager: TilesManager!

  override func setUp() {
    super.setUp()

    sequentialTilesManager = TilesManager(count: 16)
    sequentialTilesManager.loadAndSliceImage(image: UIImage(named: "Pic-SanFrancisco")!, toShuffle: false)
    shuffledTilesManager = TilesManager(count: 16)
    shuffledTilesManager.loadAndSliceImage(image: UIImage(named: "Pic-SanFrancisco")!)
  }

  override func tearDown() {
    sequentialTilesManager = nil
    shuffledTilesManager = nil
    super.tearDown()
  }

  func testIsCompleteUsingSequentialSet() {
    XCTAssert(sequentialTilesManager.isComplete(), "Is complete using sequential set")
  }

  func testIsCompleteUsingShuffledSet() {
    XCTAssertFalse(shuffledTilesManager.isComplete(), "Is complete using shuffled set")
  }
}
