//
//  MutableCollection.swift
//  Puzzle15
//
//  Created by Samuel Chow on 7/23/18.
//  Copyright © 2018 Samuel Chow. All rights reserved.
//

import Foundation

extension MutableCollection {
  // Shuffles the contents of this collection.
  // Credit: https://stackoverflow.com/questions/24026510/how-do-i-shuffle-an-array-in-swift
  mutating func shuffle() {
    let c = count
    guard c > 1 else { return }

    for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
      let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
      let i = index(firstUnshuffled, offsetBy: d)
      swapAt(firstUnshuffled, i)
    }
  }
}
