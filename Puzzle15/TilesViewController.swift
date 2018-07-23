//
//  TilesViewController.swift
//  Puzzle15
//
//  Created by Samuel Chow on 7/20/18.
//  Copyright © 2018 Samuel Chow. All rights reserved.
//

import UIKit

let reuseIdentifier = "TileCellIdentifer"

class TilesViewController: UIViewController, UICollectionViewDataSource,
UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

  // Visual components.
  @IBOutlet weak var collectionView: UICollectionView!

  // Non-visual components.
  lazy var unsplashManager: UnsplashManager = {
    return UnsplashManager()
  }()

  // State variables.
  var tiles: [Tile] = []
  var imagesMetadata: [ImageMetadata]? = []
  var isRefreshEnabled = false  // There's no user interaction disablement for UIButtonItem.
  var imageMetaIndex = 0        // The current image (referenced by index).

  // Configuration.
  enum Constants {
    static let margin: CGFloat = 8
    static let size = 16
    static let cellsPerRow = 4
  }

  // MARK: - Helper functions

  // Slice the image and display the sliced images as tiles.
  func displayTiles(image: UIImage) {
    // Crop the image.
    let slicedImages = sliceImage(image: image,
                                  rows: Constants.cellsPerRow,
                                  columns: Constants.cellsPerRow)

    // Initialize the array of tiles.
    tiles.removeAll()
    for i in 0...Constants.size-1 {
      if i < Constants.size-1 {
        // Tile index starts from 1.
        tiles.append(Tile(index: i+1, image: slicedImages[i]))
      } else {
        tiles.append(Tile(index: i+1))
      }
    }

    // Shuffle the tiles.
    tiles.shuffle()

    self.collectionView.reloadData()
    isRefreshEnabled = true
  }

  // Use an embedded image if no image is retrieved from the Internet.
  func displayEmbeddedImage() {
    self.displayTiles(image: UIImage(named: "Pic-SanFrancisco")!)
  }

  // Retrieve an array of images metadata (so that we can recycle thru) and
  // load a image to the tiles.
  func fetchImagesMetadataAndLoadImage() {
    // Retrieve an image.
    self.unsplashManager.fetchImagesMetadata { (imagesMetadata) in
      self.imagesMetadata = imagesMetadata

      self.loadImage(index: self.imageMetaIndex)
    }
  }

  // Load image to the tiles.
  func loadImage(index: Int) {
    guard let url = self.imagesMetadata?[index].url else {
      print("Can't retrieve image metadata. Slicing default image to tiles...")

      // Use the embedded image.
      self.displayEmbeddedImage()
      return
    }

    self.unsplashManager.fetchImage(url: url, complete: { (image) in
      guard let image = image else {
        print("Can't download image. Slicing the default image to tiles...")

        // Use the embedded image.
        self.displayEmbeddedImage()
        return
      }

      self.displayTiles(image: image)
    })
  }

  // MARK: Action Handlers

  @IBAction func refreshButtonDidPress(sender: UIBarButtonItem) {
    if isRefreshEnabled == false, imagesMetadata!.count < 1 {
      return
    }

    isRefreshEnabled = false
    imageMetaIndex = (imageMetaIndex + 1) % (imagesMetadata!.count - 1)
    loadImage(index: imageMetaIndex)
  }

  // MARK: - UIViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()

    fetchImagesMetadataAndLoadImage();
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  // MARK: - UICollectionViewDelegateFlowLayout

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return Constants.margin
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return Constants.margin
  }

  // MARK: - UICollectionViewDatasource

  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return Constants.size
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                  for: indexPath)

    guard tiles.count > 0, let imageCell = cell as? TileCollectionViewCell else {
      return cell
    }

    imageCell.button.setImage(tiles[indexPath.row].image, for: .normal)
    
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellsPerRow = CGFloat(Constants.cellsPerRow)
    let width = (UIScreen.main.bounds.width - (cellsPerRow + 1) * Constants.margin) / cellsPerRow
    let height = (UIScreen.main.bounds.height - (cellsPerRow + 1) * Constants.margin) / cellsPerRow

    // Make the tile a square.
    let length = (height > width) ? width : height

    return CGSize(width: length, height: length)
  }
}
