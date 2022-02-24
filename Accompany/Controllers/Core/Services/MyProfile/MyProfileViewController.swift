//
//  MyProfileViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-17.
//

import UIKit
import SnapKit

class MyProfileViewController: CustomTextViewController, ProfileDetailDelegate {
  
  let profileTableView: UITableView = {
    let profileTableView = UITableView()
    profileTableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
    profileTableView.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    profileTableView.separatorStyle = .none
    
    return profileTableView
  }()
  
  let userImageView = UIImageView(image: UIImage(systemName: "person.fill"))
  
  var infoArray: [Info] = [
  Info(text: "Username:"),
  Info(text: "Email:"),
  Info(text: "Baby's name:"),
  Info(text: "Status Message:"),
  Info(text: "Bio:")
  ]
 
  override func viewDidLoad() {
    super.viewDidLoad()
    
    titleLabel.text = Services.myProfile.description
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
    userImageView.isUserInteractionEnabled = true
    userImageView.addGestureRecognizer(tapGestureRecognizer)
    
    userImageView.contentMode = .scaleAspectFit
    userImageView.layer.borderWidth = 1.0
    userImageView.layer.masksToBounds = false
    userImageView.layer.borderColor = #colorLiteral(red: 1, green: 0.8831380575, blue: 0.9568627451, alpha: 1)
    userImageView.layer.cornerRadius = userImageView.bounds.width / 2
    userImageView.clipsToBounds = true

    configTableView()
    setupLayout()
    
  }
  
  @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
    
    let alert = UIAlertController(title: "Accompany Would Like to Access your Photos.", message: "Choose one way to upload photos", preferredStyle: .alert)
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
  
  private func configTableView() {
    profileTableView.delegate = self
    profileTableView.dataSource = self
    
  }

  func setupLayout() {
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
    }
   
    view.addSubview(userImageView)
   
    userImageView.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(10)
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.5)
      make.height.equalTo(userImageView.snp.width).multipliedBy(0.8)
    }
   
    view.addSubview(profileTableView)
   
    profileTableView.snp.makeConstraints { make in
      make.top.equalTo(userImageView.snp.bottom).offset(45)
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width)
      make.bottom.equalTo(view.safeAreaLayoutGuide)
    }

  }
  
}

extension MyProfileViewController: UITableViewDelegate {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 65
  }

}

extension MyProfileViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return infoArray.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = profileTableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier, for: indexPath) as! ProfileCell
    let info = infoArray[indexPath.row]
    cell.update(with: info)

    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let profileDetailVC = ProfileDetailViewController()
    profileDetailVC.info = infoArray[indexPath.row]
    navigationController?.pushViewController(profileDetailVC, animated: true)
  }

}

extension MyProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let image = info[.originalImage] as! UIImage
    self.userImageView.image = image
    self.dismiss(animated: true, completion: nil)
  }

}
