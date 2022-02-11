//
//  TabBarViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-04.
//

import UIKit

class TabBarViewController: UITabBarController {
  
  enum TabBarVCTitle: String {
    case home = "Home"
    case ourBaby = "Our Baby"
    case records = "Record"
    case services = "Services"
  }
  
  let placeholderImage = UIImage(systemName: "photo.on.rectangle")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.7450980392, blue: 0.6941176471, alpha: 1)

    configureViewControllers()
  }
  
  private func configureViewControllers() {
    let homeVC = HomeViewController()
//    homeVC.title = TabBarVCTitle.home.rawValue
    homeVC.tabBarItem = UITabBarItem(title: TabBarVCTitle.home.rawValue, image: placeholderImage, tag: 1)
    
    let ourBabyVC = OurBabyViewController()
    ourBabyVC.title = TabBarVCTitle.ourBaby.rawValue
    ourBabyVC.tabBarItem = UITabBarItem(title: TabBarVCTitle.ourBaby.rawValue, image: placeholderImage, tag: 1)
    
    let recordsVC = RecordsViewController()
    recordsVC.title = TabBarVCTitle.records.rawValue
    recordsVC.tabBarItem = UITabBarItem(title: TabBarVCTitle.records.rawValue, image: placeholderImage, tag: 1)
    
    let servicesVC = ServicesViewController()
    servicesVC.title = TabBarVCTitle.services.rawValue
    servicesVC.tabBarItem = UITabBarItem(title: TabBarVCTitle.services.rawValue, image: placeholderImage, tag: 1)
    
    let vcs = [homeVC, ourBabyVC, recordsVC, servicesVC]
    
    self.viewControllers = vcs.map { UINavigationController(rootViewController: $0) }
  }

}
