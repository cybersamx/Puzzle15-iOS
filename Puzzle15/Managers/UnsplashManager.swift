//
//  UnsplashManager.swift
//  Puzzle15
//
//  Created by Samuel Chow on 7/22/18.
//  Copyright © 2018 Samuel Chow. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class UnsplashManager {
  // MARK: - Functions

  func fetchImagesMetadata(complete: @escaping ([ImageMetadata]?) -> Void) {
    // Configure request
    let url = "https://api.unsplash.com/photos/"
    let params = [
      "client_id": ConfigManager.shared.unsplashAccessKey as Any
    ]
    let headers = [
      "Accept": "application/json"
    ]

    // Make the request
    Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers)
      .validate()
      .responseJSON { (response) in
        guard response.result.isSuccess else {
          print("Failed to fetch images metedata from \(url)\n.Details: \(String(describing: response.result.error))")
          complete(nil)
          return
        }

        guard let jsonArray = response.result.value as? [Any] else {
          print("Bad data received...")
          complete(nil)
          return
        }

        let imagesMetadata = jsonArray.map({ (jsonElement) -> ImageMetadata in
          let json = JSON(jsonElement)
          let url = json["urls"]["regular"].stringValue
          let width = json["width"].doubleValue
          let height = json["height"].doubleValue
          let username = json["username"].stringValue
          return ImageMetadata(url: url, width: width, height: height, username: username)
        })

        complete(imagesMetadata)
    }
  }

  func fetchImage(urlString: String, flushCache: Bool = false, complete: @escaping (UIImage?) -> Void) {
    // Configure request
    let params = [
      "client_id": ConfigManager.shared.unsplashAccessKey as Any
    ]

    // Flush the system image cache
    if flushCache {
      guard let url = URL(string: urlString) else {
        return
      }

      let urlRequest = URLRequest(url: url)
      URLCache.shared.removeCachedResponse(for: urlRequest)
    }

    // Make the request
    Alamofire.request(urlString, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil)
      .validate()
      .responseImage { response in
        guard let image = response.result.value else {
          print("Failed to fetch image from \(urlString)\n.Details: \(String(describing: response.result.error))")
          complete(nil)
          return
        }

        complete(image)
      }
  }
}
