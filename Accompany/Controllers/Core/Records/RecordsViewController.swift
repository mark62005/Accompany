//
//  RecordsViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-04.
//

import UIKit

class RecordsViewController: UIViewController {
  
  let goToAlbumButton = PrimaryButton(title: "Go to Baby Album")

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(goToAlbumButton)
    
    goToAlbumButton.addTarget(self, action: #selector(gotoBabyAlbum(_:)), for: .touchUpInside)
    
    setupBtnLayout()

  }
  
  @objc func gotoBabyAlbum(_ button: UIButton) {
    let babyVC = BabySonogramController()
    
    navigationController?.pushViewController(babyVC, animated: true)

  }
  
  func setupBtnLayout() {
    
    goToAlbumButton.snp.makeConstraints { make in
      make.centerX.equalTo(view)
      make.centerY.equalTo(view)
      make.width.equalTo(150)
      make.height.equalTo(40)
    }

  }
  
  
}

