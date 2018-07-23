//
//  ImageProcessor.swift
//  Puzzle15
//
//  Created by Samuel Chow on 7/22/18.
//  Copyright © 2018 Samuel Chow. All rights reserved.
//

import Foundation
import UIKit

func cropToSquare(image: UIImage) -> UIImage {
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

func crop(image: UIImage, rect: CGRect) -> UIImage {
  let cgImage = image.cgImage!
  let targetCGImage = cgImage.cropping(to: rect)!
  let targetImage = UIImage(cgImage: targetCGImage, scale: image.scale, orientation: image.imageOrientation)

  return targetImage
}

func sliceImage(image: UIImage, rows: Int, columns: Int) -> [UIImage] {
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
