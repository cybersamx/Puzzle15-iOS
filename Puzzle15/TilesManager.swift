//
//  TilesManager.swift
//  Puzzle15
//
//  Created by Samuel Chow on 7/23/18.
//  Copyright © 2018 Samuel Chow. All rights reserved.
//

import Foundation
import UIKit

class TilesManager {
  // Configuration.
  var count = 16          // Number of tiles.
  var countPerRow = 4     // Number of tiles per row.

  // State variables.
  var tiles: [Tile] = []
  var completeImage: UIImage? = nil

  init(count: Int, countPerRow: Int) {
    self.count = count
    self.countPerRow = countPerRow
  }

  // MARK: - Private image helper fucntions

  private func cropToSquare(image: UIImage) -> UIImage {
    // Due to the DPI, we need to convert a CG image and reconvert back to a UIImage to get the correct
    // width and height. For example: the actual image size is 32x32, so the image object reads 32x32 while
    // context image reads 64x64 if the higher res image is loaded to a device screen supporting retina.
    // See: https://stackoverflow.com/questions/32041420/cropping-image-with-swift-and-put-it-on-center-position
    let cgImage = image.cgImage!
    let contextImage = UIImage(cgImage: cgImage)
    let contextSize = contextImage.size
    var targetX, targetY, targetWidth, targetHeight: CGFloat

    // Determine the origin to move the image and readjust the size.
    if contextSize.width > contextSize.height {
      targetX = ((contextSize.width - contextSize.height) / 2)
      targetY = 0
      targetWidth = contextSize.height
      targetHeight = contextSize.height
    } else {
      targetX = 0
      targetY = ((contextSize.height - contextSize.width) / 2)
      targetWidth = contextSize.width
      targetHeight = contextSize.width
    }

    let rect = CGRect(x: targetX, y: targetY, width: targetWidth, height: targetHeight)

    // Create a bitmap image with the cropped size and then recreate a new UIImage.
    let targetCGImage = cgImage.cropping(to: rect)!
    let targetImage = UIImage(cgImage: targetCGImage, scale: 1.0, orientation: image.imageOrientation)

    return targetImage
  }

  private func crop(image: UIImage, rect: CGRect) -> UIImage {
    let cgImage = image.cgImage!
    let targetCGImage = cgImage.cropping(to: rect)!
    let targetImage = UIImage(cgImage: targetCGImage, scale: image.scale, orientation: image.imageOrientation)

    return targetImage
  }

  private func sliceImage(image: UIImage, rows: Int, columns: Int) -> [UIImage] {
    // Crop the big image into a square image.
    let croppedImage = cropToSquare(image: image)

    let colLength: CGFloat = croppedImage.size.width/CGFloat(columns)
    let rowLength: CGFloat = croppedImage.size.height/CGFloat(rows)
    var slicedImages = [UIImage]()

    for i in 0...rows-1 {
      for j in 0...columns-1 {
        let rect = CGRect(x: CGFloat(j)*colLength, y: CGFloat(i)*rowLength,
                          width: colLength, height: rowLength)
        let slicedImage = crop(image: croppedImage, rect: rect)
        slicedImages.append(slicedImage)
      }
    }

    return slicedImages
  }

  // Suffle the tiles until we get a solvable set.
  func shuffle() {
    repeat {
      // Shuffle the tiles.
      tiles.shuffle()

      // Reindex the current indices.
      for i in 0...tiles.count-1 {
        tiles[i].currentIndex = i
      }
    } while !TilesManager.isSolvable(tiles: tiles)
  }

  // MARK: - Class functions

  // Credits:
  // 1. Algorithm based on https://www.cs.bham.ac.uk/~mdr/teaching/modules04/java2/TilesSolvability.html
  // 2. Code modified from https://stackoverflow.com/questions/34570344/check-if-15-puzzle-is-solvable

  static func isSolvable(tiles: [Tile]) -> Bool {
    // Algorithm assumes NxN grid but we pass a 1-dimension serialized array representing
    // the puzzle.
    var parity = 0
    let gridWith = Int(sqrt(Double(tiles.count)))
    var row = 0         // The current row we are on.
    var blankRow = 0    // The row with the blank tile.

    for i in 0...tiles.count-1 {
      if (i % gridWith == 0) {
        // Advance to the next row.
        row += 1
      }

      if tiles[i].isEmpty {
        // The blank tile
        blankRow = row
        continue
      }

      if i+1 >= tiles.count {
        continue
      }

      for j in i+1...tiles.count-1 {
        if !tiles[i].isEmpty && !tiles[j].isEmpty && tiles[i].index > tiles[j].index {
          parity += 1
        }
      }
    }

    if gridWith % 2 == 0 {
      // Even gird
      if blankRow % 2 == 0 {
        // Blank on odd row, counting from bottom.
        return parity % 2 == 0
      } else {
        // Blank on even row, counting from bottom.
        return parity % 2 != 0
      }
    } else {
      // Odd grid.
      return parity % 2 == 0
    }
  }

  // MARK: - Instance functions

  func loadAndSliceImage(image: UIImage) {
    // Crop the image.
    let slicedImages = sliceImage(image: image,
                                  rows: countPerRow,
                                  columns: countPerRow)

    // Initialize the array of tiles.
    tiles.removeAll()
    for i in 0...count-1 {
      if i < count-1 {
        tiles.append(Tile(index: i, image: slicedImages[i]))
      } else {
        tiles.append(Tile(index: i))
      }
    }

    // Shuffle the tiles.
    shuffle()
  }

  // Given a tile index, get an array of indices that are adjacent to the tile.
  func indicesAdjacentTo(index: Int) -> [Int] {
    var adjacentIndices: [Int] = []
    let tile = tiles.first { (tile) -> Bool in
      return tile.index == index
    }

    if tile == nil {
      return adjacentIndices
    }

    // Check left.
    if ((tile!.index + 1) % countPerRow) != 1 {
      adjacentIndices.append(tile!.index - 1)
    }

    // Check top.
    if (tile!.index + 1) > countPerRow {
      adjacentIndices.append(tile!.index - countPerRow)
    }

    // Check right.
    if ((tile!.index + 1) % countPerRow) != 0 {
      adjacentIndices.append(tile!.index + 1)
    }

    // Check bottom.
    if (tile!.index + 1) < (count - countPerRow + 1) {
      adjacentIndices.append(tile!.index + countPerRow)
    }

    return adjacentIndices
  }

  func getEmptyTile() -> Tile? {
    let emptyTile = tiles.first { (tile) -> Bool in
      return tile.isEmpty
    }

    return emptyTile
  }

  func moveToEmptyTile(from: Tile) -> Bool {
    // Sanity check to make sure that the tile is adjacent to empty tile.
    guard let emptyTile = getEmptyTile() else {
      return false
    }
    let indices = indicesAdjacentTo(index: emptyTile.currentIndex)
    if !indices.contains(from.currentIndex) {
      return false
    }

    // Move the tile to the empty tile.
    tiles.remove(at: emptyTile.currentIndex)
    tiles.insert(from, at: emptyTile.currentIndex)
    tiles.remove(at: from.currentIndex)
    tiles.insert(emptyTile, at: from.currentIndex)
    let tmpIndex = emptyTile.currentIndex
    emptyTile.currentIndex = from.currentIndex
    from.currentIndex = tmpIndex

    return true
  }
}
