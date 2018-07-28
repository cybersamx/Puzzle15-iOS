# Puzzle15-iOS

## Overview

A native iOS [15-tile puzzle game](https://en.wikipedia.org/wiki/15_puzzle) using data and images made publicly available through the [Unsplash API](https://unsplash.com/developers). Features of the app:

* Get an image from Unsplash and break it into 15 tiles
* Randomize the tiles without rendering the puzzle unsolvable
* Move the tiles
* Play the next set of tiles when the puzzle is completed

## Run the App

1. Install Cocoapods

   ```bash
   $ bundle
   ```

1. Install Swift dependencies needed by the project

   ```bash
   $ pod install
   ```

1. **IMPORTANT**: Copy the config file and enter your Unsplash API keys. You can register for a free account on [Unsplash](https://unsplash.com/oauth/applications).

   ```bash
   $ cd Puzzle15
   $ cp Puzzle15.plist.example Puzzle.plist
   $ vi Puzzle15.plist   # Enter your API keys
   ```

1. Open the project in Xcode and run

   ```bash
   $ open Puzzle15.xcworkspace
   ```

## Test the App

The project includes both unit and UI tests. Select CMD-U to run the tests.

## References

* [Swift coding standards](https://github.com/raywenderlich/swift-style-guide)
* [15 puzzle solvability algorithm explained](https://www.cs.bham.ac.uk/~mdr/teaching/modules04/java2/TilesSolvability.html)
* [15 puzzle solvability code in Java](https://stackoverflow.com/questions/34570344/check-if-15-puzzle-is-solvable)
