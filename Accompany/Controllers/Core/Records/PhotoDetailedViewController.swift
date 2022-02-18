//
//  PhotoDetailedViewController.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-17.
//

import UIKit

class PhotoDetailedViewController: UIViewController {
  
//  let detailTitleLabel = TitleLabel(title: "Photo Information")
//  let infoTitleLabel = TitleLabel(smallerTitle: "Date")
  
  let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "photo.on.rectangle")
    imageView.backgroundColor = .clear
    
    return imageView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    
//        setupLayout()

  }
  
//  func setupLayout() {
//
//    view.addSubview(detailTitleLabel)
//    view.addSubview(imageView)
//    view.addSubview(infoTitleLabel)
//
//    detailTitleLabel.snp.makeConstraints { make in
//      make.top.equalTo(view.safeAreaLayoutGuide)
//      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
//      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
//    }
//
//    imageView.snp.makeConstraints { make in
//      make.centerX.equalTo(view)
//      make.centerY.equalTo(view)
//    }
//
//    infoTitleLabel.snp.makeConstraints { make in
//      make.top.equalTo(imageView.snp.bottom).offset(30)
//      make.left.equalTo(view.safeAreaLayoutGuide).offset(40)
//      make.right.equalTo(view.safeAreaLayoutGuide).offset(-40)
//    }
//  }

}
