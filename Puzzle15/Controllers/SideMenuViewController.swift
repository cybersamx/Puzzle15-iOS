//
//  SideMenuViewController.swift
//  Puzzle15
//
//  Created by Samuel Chow on 7/26/18.
//  Copyright © 2018 Samuel Chow. All rights reserved.
//

import Foundation
import SideMenu
import UIKit

class SideMenuViewController: UITableViewController {
  weak var tilesController: TilesViewController?

  @IBOutlet weak var shuffleSwitch: UISwitch!
  @IBOutlet weak var showHintSwitch: UISwitch!

  // MARK: - Action Handlers

  @IBAction func shuffleSwitchDidPress(sender: UISwitch) {
    dismiss(animated: true, completion: nil)
    ConfigManager.shared.shuffle = shuffleSwitch.isOn
  }

  @IBAction func showHintSwitchDidPress(sender: UISwitch) {
    dismiss(animated: true, completion: nil)
    ConfigManager.shared.showHint = showHintSwitch.isOn
    tilesController?.showHint()
  }

  // MARK: - UIViewController

  override func viewDidLoad() {
    super.viewDidLoad()

    showHintSwitch.isOn = ConfigManager.shared.showHint
    shuffleSwitch.isOn = ConfigManager.shared.shuffle
  }

  // MARK: - UITableViewDelegate

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if (indexPath.row == 0) {
      // About.
      dismiss(animated: true, completion: nil)
      tilesController?.showAboutDialog()
    } else if indexPath.row == 1 {
      // Reset.
      dismiss(animated: true, completion: nil)
      tilesController?.reset(toNext: false)
    } else if indexPath.row == 2 {
      // Next.
      dismiss(animated: true, completion: nil)
      tilesController?.reset(toNext: true)
    }
  }
}
