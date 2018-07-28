//
//  TilesViewController.swift
//  Puzzle15
//
//  Created by Samuel Chow on 7/20/18.
//  Copyright © 2018 Samuel Chow. All rights reserved.
//

import UIKit
import SideMenu

let reuseIdentifier = "TileCellIdentifer"

class TilesViewController: UIViewController, UICollectionViewDataSource,
UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  // Configuration.
  enum Constants {
    static let margin: CGFloat = 8
    static let count = 16
  }

  // Visual components.
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var hintOverlay: UIView!

  // Non-visual components.
  private lazy var unsplashManager: UnsplashManager = createUnsplashManager()
  private lazy var tilesManager: TilesManager = createTilesManager()

  // State variables.
  private var imagesMetadata: [ImageMetadata]? = []
  private var imageMetaIndex = 0        // The current image (referenced by index).
  var isResetEnabled = false  // There's no user interaction disablement for UIButtonItem.

  // MARK: - Helper functions

  private func createUnsplashManager() -> UnsplashManager {
    return UnsplashManager()
  }

  private func createTilesManager() -> TilesManager {
    return TilesManager(count: Constants.count)
  }

  // Slice the image and display the sliced images as tiles.
  func displayTiles(image: UIImage) {
    tilesManager.loadAndSliceImage(image: image, toShuffle: ConfigManager.shared.shuffle)

    collectionView.reloadData()
    isResetEnabled = true
  }

  // Use an embedded image if no image is retrieved from the Internet.
  func displayEmbeddedImage() {
    displayTiles(image: UIImage(named: "Pic-SanFrancisco")!)
  }

  // Retrieve an array of images metadata (so that we can recycle thru) and
  // load a image to the tiles.
  func fetchImagesMetadataAndLoadImage() {
    // Retrieve an image.
    unsplashManager.fetchImagesMetadata { [weak self] (imagesMetadata) in
      guard let sself = self else {
        return
      }

      sself.imagesMetadata = imagesMetadata

      sself.loadImage(index: sself.imageMetaIndex)
    }
  }

  // Load image to the tiles.
  func loadImage(index: Int) {
    guard let url = imagesMetadata?[index].url else {
      print("Can't retrieve image metadata. Slicing default image to tiles...")

      // Use the embedded image.
      displayEmbeddedImage()
      return
    }

    unsplashManager.fetchImage(url: url, complete: { [weak self] (image) in
      guard let sself = self else {
        return
      }

      guard let image = image else {
        print("Can't download image. Slicing the default image to tiles...")

        // Use the embedded image.
        sself.displayEmbeddedImage()
        return
      }

      sself.displayTiles(image: image)
    })
  }

  // MARK: - Instance Methods

  // Reset the tiles set.
  func reset(toNext: Bool = false) {
    if isResetEnabled == false, imagesMetadata!.count == 0 {
      return
    }

    // Unsplash returns 10 images by default. We cycle through the set of images when the user
    // tap the reset button.
    isResetEnabled = false
    imageMetaIndex = toNext ?
      (imageMetaIndex + 1) % (imagesMetadata!.count - 1) : imageMetaIndex
    loadImage(index: imageMetaIndex)
  }

  func showHint() {
    collectionView.reloadData()
  }

  func showAboutDialog() {
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    let alert = UIAlertController(title: "About", message: "Alert15\nVersion \(version).", preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(okAction)
    present(alert, animated: true, completion: nil)
  }

  // MARK: - UICollectionViewDelegate

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedTile = tilesManager.tiles[indexPath.row]

    if tilesManager.moveToEmptyTile(from: selectedTile) {
      collectionView.reloadData()
    }

    // Check the tiles set is complete.
    if tilesManager.isComplete() {
      let alert = UIAlertController(title: "Score!!!", message: "You completed the puzzle.", preferredStyle: .alert)
      let replayAction = UIAlertAction(title: "Replay", style: .default, handler: { (action) in
        self.reset(toNext: false)    // Reshuffle the current tiles set.
      })
      let nextAction = UIAlertAction(title: "Next", style: .default, handler: { (action) in
        self.reset(toNext: true)    // Get and shuffle the next tiles set.
      })
      alert.addAction(replayAction)
      alert.addAction(nextAction)

      present(alert, animated: true, completion: nil)
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

  // MARK: - UIViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.title = "Puzzle15"
    fetchImagesMetadataAndLoadImage();
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showMenu" {
      if let navController = segue.destination as? UISideMenuNavigationController,
        let menuController = navController.topViewController as? SideMenuViewController {
        menuController.tilesController = self
      }
    }
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
    imageCell.indexLabel.text = String(format: "\(tilesManager.tiles[indexPath.row].index)")
    imageCell.indexLabel.isHidden = !ConfigManager.shared.showHint

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellsPerRow = CGFloat(tilesManager.gridWidth)
    let width = (UIScreen.main.bounds.width - (cellsPerRow + 1) * Constants.margin) / cellsPerRow
    let height = (UIScreen.main.bounds.height - (cellsPerRow + 1) * Constants.margin) / cellsPerRow

    // Make the tile a square.
    let length = (height > width) ? width : height

    return CGSize(width: length, height: length)
  }
}
