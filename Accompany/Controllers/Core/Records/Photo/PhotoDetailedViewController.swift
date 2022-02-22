//
//  PhotoDetailedViewController.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-17.
//

import UIKit

class PhotoDetailedViewController: UIViewController {
  
  let detailTitleLabel = TitleLabel(title: "Photo Information", size: .medium)
  let infoTitleLabel = TitleLabel(title: "Date", size: .small)
  
  let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "photo.on.rectangle")
    imageView.backgroundColor = .clear
    
    return imageView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
  
    setupLayout()
  }
  
  func setupLayout() {
    
    view.addSubview(detailTitleLabel)
    view.addSubview(imageView)
    view.addSubview(infoTitleLabel)
    
  }
 
}
