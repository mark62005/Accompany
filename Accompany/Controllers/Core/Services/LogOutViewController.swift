//
//  LogOutViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-17.
//

import UIKit

class LogOutViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    title = Services.logOut.description
    view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.7450980392, blue: 0.6941176471, alpha: 1)
  }

}
