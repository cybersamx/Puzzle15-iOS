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
  // Configuration.
  enum Constants {
    static let margin: CGFloat = 8
    static let count = 16
    static let countPerRow = 4
  }

  // Visual components.
  @IBOutlet weak var collectionView: UICollectionView!

  // Non-visual components.
  lazy var unsplashManager: UnsplashManager = {
    return UnsplashManager()
  }()
  lazy var tilesManager: TilesManager = {
    return TilesManager(count: Constants.count, countPerRow: Constants.countPerRow)
  }()

  // State variables.
  var imagesMetadata: [ImageMetadata]? = []
  var isRefreshEnabled = false  // There's no user interaction disablement for UIButtonItem.
  var imageMetaIndex = 0        // The current image (referenced by index).

  // MARK: - Helper functions

  // Slice the image and display the sliced images as tiles.
  func displayTiles(image: UIImage) {
    tilesManager.loadAndSliceImage(image: image)

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

  // MARK: - UICollectionViewDelegate

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedTile = tilesManager.tiles[indexPath.row]

    if tilesManager.moveToEmptyTile(from: selectedTile) {
      collectionView.reloadData()
    }
  }

  func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    // Only enable cells adjacent to the empty cell selectable.
    guard let emptyTile = tilesManager.getEmptyTile() else {
      return false
    }

    let indices = tilesManager.indicesAdjacentTo(index: emptyTile.currentIndex)
    return indices.contains(indexPath.row)
  }

  // MARK: - Action Handlers

  @IBAction func refreshButtonDidPress(sender: UIBarButtonItem) {
    if isRefreshEnabled == false, imagesMetadata!.count < 1 {
      return
    }

    // Unsplash returns 10 images by default. We cycle through the set of images when the user
    // tap the refresh button.
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
    return tilesManager.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                  for: indexPath)

    guard tilesManager.tiles.count > 0, let imageCell = cell as? TileCollectionViewCell else {
      return cell
    }

    imageCell.imageView.image = tilesManager.tiles[indexPath.row].image

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellsPerRow = CGFloat(tilesManager.countPerRow)
    let width = (UIScreen.main.bounds.width - (cellsPerRow + 1) * Constants.margin) / cellsPerRow
    let height = (UIScreen.main.bounds.height - (cellsPerRow + 1) * Constants.margin) / cellsPerRow

    // Make the tile a square.
    let length = (height > width) ? width : height

    return CGSize(width: length, height: length)
  }
}
