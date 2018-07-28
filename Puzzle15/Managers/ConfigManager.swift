//
//  ConfigManager.swift
//  Puzzle15
//
//  Created by Samuel Chow on 7/23/18.
//  Copyright © 2018 Samuel Chow. All rights reserved.
//

import Foundation

class ConfigManager {
  static let shared = ConfigManager()

  var unsplashAccessKey: String
  var unsplashSecretKey: String
  var showHint: Bool {
    didSet {
      UserDefaults.standard.set(showHint, forKey: "ShowHint")
    }
  }
  var shuffle: Bool {
    didSet {
      UserDefaults.standard.set(shuffle, forKey: "Shuffle")
    }
  }

  private init() {
    guard let path = Bundle.main.path(forResource: "Puzzle15", ofType: "plist"),
          let dict = NSDictionary(contentsOfFile: path) as? [String: Any?] else {
            unsplashAccessKey = ""
            unsplashSecretKey = ""
            showHint = false
            shuffle = false
            print("ERROR! The config file is empty. Make sure Puzzle.plist is populated.")

            return
    }

    unsplashAccessKey = dict["UnsplashAccessKey"] as! String
    unsplashSecretKey = dict["UnsplashSecretKey"] as! String
    showHint = UserDefaults.standard.bool(forKey: "ShowHint") || dict["ShowHint"] as! Bool
    shuffle = UserDefaults.standard.bool(forKey: "Shuffle") || dict["Shuffle"] as! Bool
  }
}
