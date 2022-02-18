//
//  FeedbackViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-17.
//

import UIKit

class FeedbackViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    title = AccountSettings.feedback.rawValue
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
  }
  
}
