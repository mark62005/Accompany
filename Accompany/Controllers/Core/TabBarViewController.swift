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
    case timer = "Timer"
    case services = "Services"
  }
  
  let placeholderImage = UIImage(systemName: "photo.on.rectangle")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)

    configureViewControllers()
  }
  
  private func configureViewControllers() {
    let homeVC = HomeViewController()
//    homeVC.title = TabBarVCTitle.home.rawValue
    homeVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "home-menu-icon-active"), tag: 1)

    let ourBabyVC = OurBabyViewController()
//    ourBabyVC.title = TabBarVCTitle.ourBaby.rawValue
    ourBabyVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "baby-menu-icon"), tag: 1)
    
    let recordsVC = RecordsViewController()
//    recordsVC.title = TabBarVCTitle.records.rawValue
    recordsVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "record-menu-icon-active"), tag: 1)
    
    let contractionTimerVC = ContractionTimerViewController()
//    contractionTimerVC.title = TabBarVCTitle.timer.rawValue
    contractionTimerVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "stopwatch-menu-active"), tag: 1)
    
    let servicesVC = ServicesViewController()
    servicesVC.titleLabel.text = TabBarVCTitle.services.rawValue
    servicesVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "service-menu-icon-active"), tag: 1)
    
    let vcs = [homeVC, ourBabyVC, recordsVC, contractionTimerVC, servicesVC]
    
    self.viewControllers = vcs.map { UINavigationController(rootViewController: $0) }
  }

}
