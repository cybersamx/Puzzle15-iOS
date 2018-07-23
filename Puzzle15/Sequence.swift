//
//  Sequence.swift
//  Puzzle15
//
//  Created by Samuel Chow on 7/23/18.
//  Copyright © 2018 Samuel Chow. All rights reserved.
//

import Foundation

extension Sequence {
  // Returns an array with the contents of this sequence, shuffled.
  // Credit: https://stackoverflow.com/questions/24026510/how-do-i-shuffle-an-array-in-swift
  func shuffled() -> [Element] {
    var result = Array(self)
    result.shuffle()
    return result
  }
}
