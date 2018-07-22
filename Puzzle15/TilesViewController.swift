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

  @IBOutlet var collectionView: UICollectionView!
  var tiles = [Tile]()

  enum Constants {
    static let margin: CGFloat = 8
    static let size = 16
    static let cellsPerRow = 4
  }

  // MARK: UIViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Initialize the array of images.
    for i in 0...Constants.size-1 {
      if i < Constants.size-1 {
        tiles.append(Tile(index: i, image: UIImage(named: "Logo-iOS")!))
      } else {
        tiles.append(Tile(index: i))
      }
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  // MARK: UICollectionViewDelegateFlowLayout

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return Constants.margin
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return Constants.margin
  }

  // MARK: UICollectionViewDatasource

  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return Constants.size
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                  for: indexPath)

    if let imageCell = cell as? TileCollectionViewCell {
      imageCell.imageView.image = tiles[indexPath.row].image
    }

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
