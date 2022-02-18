//
//  OurBabyViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-04.
//

import UIKit
import SnapKit

class OurBabyViewController: UIViewController {
  
  let babyTitle = TitleLabel(title: "Baby", size: .medium, color: .red)
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "photo.on.rectangle")
    imageView.backgroundColor = .white
    return imageView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupLayout()

  }
  
  private func setupLayout() {
    view.addSubview(babyTitle)
    
    babyTitle.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
    }
  }

}
