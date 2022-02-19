////
////  LoadingViewController.swift
////  Accompany
////
////  Created by Esperanza on 2022-02-18.
////
//
//import UIKit
//
//class LoadingViewController: UIViewController {
//
//  let babyImage: UIImageView = {
//    let babyImage = UIImageView()
//    babyImage.image = UIImage(named: "logo-app.png")
//    babyImage.translatesAutoresizingMaskIntoConstraints = false
//    
//    return babyImage
//  }()
//  
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
//    
//    setupLayout()
//    
//    DispatchQueue.main.asyncAfter(deadline: .now()) {
//      self.animate()
//    }
//  }
//    
//  private func setupLayout() {
//    view.addSubview(babyImage)
//    
//    babyImage.snp.makeConstraints { make in
//      make.centerX.equalTo(view)
//      make.centerY.equalTo(view)
//      make.width.equalTo(view.snp.width).multipliedBy(0.8)
//      make.height.equalTo(view.snp.height).multipliedBy(0.4)
//    }
//    
//  }
//  
//  private func animate() {
//    
////    UIImageView.animate(withDuration: 1.5, animations: { self.babyImage.alpha = 0 }, completion: { done in
////
////      if done {
//        let tabVC = TabBarViewController()
//        tabVC.modalPresentationStyle = .fullScreen
//    tabVC.modalTransitionStyle = .crossDissolve
//        self.present(tabVC, animated: true)
////      }
////    })
////
//      
////        self.presentedViewController(tabVC, animated: true)
//        
//      }
//
//   
//
//  
//}
