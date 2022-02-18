//
//  BabySonogramController.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-14.
//

import Foundation
import Photos
import PhotosUI
import UIKit
import SnapKit

class BabySonogramController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
  
  // MARK: Section Definitions
  enum Section {
    case videoSection
    case photoSection
  }

  let appName = "Accompany"
  
  let babyTitleLabel = TitleLabel(title: "Baby's Sonogram", size: .medium)
  
  let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())

  // MARK: Data
  var images = [URL]()

  let sections = [Section.videoSection, Section.photoSection]

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    view.addSubview(babyTitleLabel)
    
    setupLabelLayout()

    collectionView.setCollectionViewLayout(setupCollectionLayout(), animated: false)

    configCollectionView()

    view.addSubview(collectionView)
    collectionView.snp.makeConstraints { make in
      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
      make.top.equalTo(babyTitleLabel.snp.bottom).offset(5)
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
    }

    collectionView.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)

    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didPressAdd))
    
  }
  
  @objc func didPressAdd() {

    let alert = UIAlertController(title: "\(appName) APP Would Like to Access your Photos.", message: "Choose one way to upload photos", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
      self.openCamera()
    }))
    alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (_) in
      self.openPhotoGallery()
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
    print("User click Dismiss button")
    }))
    
    self.present(alert, animated: true, completion: {
    print("completion block")
    })
    
  }

  func openCamera() {

    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      let imagePicker = UIImagePickerController()
      imagePicker.delegate = self
      imagePicker.sourceType = .camera
      imagePicker.allowsEditing = true

      self.present(imagePicker, animated: true, completion: nil)
      }

    }

  func openPhotoGallery() {

    if UIImagePickerController.isSourceTypeAvailable((.photoLibrary)) {
      let imagePicker = UIImagePickerController()
      imagePicker.delegate = self
      imagePicker.sourceType = .photoLibrary
      imagePicker.allowsEditing = true

      self.present(imagePicker, animated: true, completion: nil)
      }
    
  }

  private func configCollectionView() {

    collectionView.delegate = self
    collectionView.dataSource = self

    collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
    
  }

  private func setupLabelLayout() {
    babyTitleLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
    }
    
  }

  func setupCollectionLayout() -> UICollectionViewLayout {

    let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
    let spacing: CGFloat = 4.0
    let section = self.sections[sectionIndex]

    switch section {
      case .videoSection:
       // Section 1 - 'Full' - A full width item
       let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(2/3))
       let item = NSCollectionLayoutItem(layoutSize: itemSize)
       item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)

       let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(2/3))
       let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

       let section = NSCollectionLayoutSection(group: group)
       section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
       section.orthogonalScrollingBehavior = .groupPaging

       return section

     case .photoSection:
       // Section 2
       // 'Triplet' - three 1/3 width items stacked horizontally
       let tripleItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalWidth(1/3)))
       tripleItem.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)

       let tripleGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/3)), subitems: [tripleItem, tripleItem, tripleItem])
       tripleGroup.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)

       // 'Double' - two 1/2 width items stacked horizontally
       let doubleItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalWidth(1/2)))
       doubleItem.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
       let doubleGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/2)), subitems: [doubleItem, doubleItem])
       doubleGroup.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)

       let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(5/3)), subitems: [tripleGroup, doubleGroup])

       let section1 = NSCollectionLayoutSection(group: nestedGroup)
       section1.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)

       return section1
      
       }
     }
    return layout

  }

}

extension BabySonogramController: UICollectionViewDelegate {
    
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
//    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
//    
//    let selectedImage = images[indexPath.item]
//    
//    se
    
//    selectedImage.addObserver(<#T##observer: NSObject##NSObject#>, forKeyPath: <#T##String#>, options: ., context: <#T##UnsafeMutableRawPointer?#>)
//
  }

  

}

extension BabySonogramController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    
    return 2
    
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return 20
    
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath)

    return cell

  }

}

