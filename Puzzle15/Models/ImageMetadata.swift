//
//  ImageMetadata.swift
//  Puzzle15
//
//  Created by Samuel Chow on 7/22/18.
//  Copyright © 2018 Samuel Chow. All rights reserved.
//

import Foundation

// Class to represent the image metadata retrieved from Unsplash.

class ImageMetadata {
  var url: String
  var width: Double
  var height: Double
  var username: String

  init(url: String, width: Double, height: Double, username: String) {
    self.url = url
    self.width = width
    self.height = height
    self.username = username
  }
}
