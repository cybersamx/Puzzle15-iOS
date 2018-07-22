//
//  Tile.swift
//  Puzzle15
//
//  Created by Samuel Chow on 7/22/18.
//  Copyright © 2018 Samuel Chow. All rights reserved.
//

import Foundation
import UIKit

class Tile {
  var index: Int
  var image: UIImage?

  init(index: Int) {
    self.index = index
    self.image = nil
  }

  init(index: Int, image: UIImage) {
    self.index = index
    self.image = image
  }
}
