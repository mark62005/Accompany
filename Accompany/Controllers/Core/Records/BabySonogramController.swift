//
//  BabySonogramController.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-14.
//

import Foundation
import PhotosUI
import UIKit
import SnapKit

class BabySonogramController: UIViewController {
  
  let babyTitleLabel = BabySonogramTitleLabel()
  
  private var collectionView : UICollectionView?
  
  var images = [UIImage]()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    view.addSubview(babyTitleLabel)
    setupLabelLayout()
     
  
    
    guard var collectionView = collectionView else {
      return
    }
    
//    var layout = setupCollectionLayout()
//    layout.scrollDirection = .vertical
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupCollectionLayout())

    configCollectionView()
    
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints { make in
      make.left.equalTo(view.safeAreaLayoutGuide).offset(50)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-50)
      make.top.equalTo(babyTitleLabel.snp.bottom).offset(20)
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
    }
    
    collectionView.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
  

    
    
    
    
  
//    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didPressAdd))
  }
  
  private func configCollectionView() {
    
    collectionView?.delegate = self
    collectionView?.dataSource = self
    
    collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
  }
  
  private func setupLabelLayout() {
    babyTitleLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(60)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-60)
    }
  
}
  
  private func setupCollectionLayout() -> UICollectionViewLayout {
    
    let spacing: CGFloat = 10
    
    // Style 1 - "Full" - A full width item
    let fullItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(2/3)))
    fullItem.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
    
    // Style2 - "Triplet" - three 1/3 width items stacked horizotally
    
    let fullItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: <#T##NSCollectionLayoutDimension#>))
    
   
    
  }
  
  
}

extension BabySonogramController: UICollectionViewDelegate {
  
}

extension BabySonogramController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 100
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath)
    
    return cell
    
  }
  
  
}
