//
//  Tile.swift
//  Puzzle15
//
//  Created by Samuel Chow on 7/22/18.
//  Copyright © 2018 Samuel Chow. All rights reserved.
//

import Foundation
import UIKit

class Tile: CustomStringConvertible {
  var index: Int          // Assigned index
  var currentIndex: Int   // Current index
  var image: UIImage?
  var isEmpty: Bool {
    return (image == nil)
  }

  init(index: Int) {
    self.index = index
    self.currentIndex = index
    self.image = nil
  }

  init(index: Int, image: UIImage) {
    self.index = index
    self.currentIndex = index
    self.image = image
  }

  var description: String {
    return String(format: "Assigned index \(index); current index \(currentIndex); isEmpty \(isEmpty)")
  }
}
