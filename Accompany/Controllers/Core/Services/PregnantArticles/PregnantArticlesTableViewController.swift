//
//  PregnantArticlesTableViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-17.
//

import UIKit

class PregnantArticlesTableViewController: UITableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = Services.pregnantArticles.description
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
  }

  // MARK: - Table view data source

}
