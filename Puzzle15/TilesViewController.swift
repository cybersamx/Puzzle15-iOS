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

  enum TileLayout {
    static let margin: CGFloat = 8
  }

  // MARK: UIViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  // MARK: UICollectionViewDelegateFlowLayout

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return TileLayout.margin
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return TileLayout.margin
  }

  // MARK: UICollectionViewDatasource

  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 16
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                  for: indexPath)

    if let imageCell = cell as? TileCollectionViewCell {
      imageCell.imageView.image = UIImage(named: "Logo-iOS")
    }

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (UIScreen.main.bounds.width - 4.0 * TileLayout.margin) / 4.0
    let height = (UIScreen.main.bounds.height - 4.0 * TileLayout.margin) / 4.0

    // Make the tile a square.
    let length = (height > width) ? width : height

    return CGSize(width: length, height: length)
  }
}
