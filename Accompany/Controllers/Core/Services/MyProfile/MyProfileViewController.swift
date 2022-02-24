//
//  MyProfileViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-17.
//
import UIKit
import SnapKit

enum InfoField: String, CaseIterable {
  
  case username = "Username"
  case email = "Email"
  case babyName = "Baby's Name"
  case statusMessage = "Status Message"
  case bio = "Bio"
  
}

class MyProfileViewController: CustomTextViewController {
  
  let profileTableView: UITableView = {
    let profileTableView = UITableView()
    profileTableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
    profileTableView.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    profileTableView.separatorStyle = .none
    
    return profileTableView
  }()
  
  let userImageView = UIImageView(image: UIImage(systemName: "person.fill"))
  
  var userInfo: Info?
  var selectedIndexPath: IndexPath?
 
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchUserInfo()
    
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
   
    self.navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "My Profile", style: .plain, target: nil, action: nil)
  }
  
  // TODO: fetch user info from db
  private func fetchUserInfo() {
    userInfo = Info.loadSampleInfo()
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
    return 5
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = profileTableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier, for: indexPath) as! ProfileCell
    
    let fieldValue: String?
    
    switch indexPath.row {
    case 0:
      fieldValue = userInfo?.username
    case 1:
      fieldValue = userInfo?.email
    case 2:
      fieldValue = userInfo?.babyName ?? "Not decided yet"
    case 3:
      fieldValue = userInfo?.statusMessage
    case 4:
      fieldValue = userInfo?.bio
    default:
      fieldValue = nil
    }
    
    cell.update(with: fieldValue ?? "")

    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let profileDetailVC = ProfileDetailViewController()
    profileDetailVC.delegate = self
    
    switch indexPath.row {
    case 0:
      profileDetailVC.fieldValue = userInfo?.username
    case 1:
      profileDetailVC.fieldValue = userInfo?.email
    case 2:
      profileDetailVC.fieldValue = userInfo?.babyName
    case 3:
      profileDetailVC.fieldValue = userInfo?.statusMessage
    case 4:
      profileDetailVC.fieldValue = userInfo?.bio
    default:
      profileDetailVC.fieldValue = ""
    }
    
    profileDetailVC.field = InfoField.allCases[indexPath.row]
    profileDetailVC.updateUI(InfoField.allCases[indexPath.row])
    
    navigationController?.pushViewController(profileDetailVC, animated: true)
    
    selectedIndexPath = indexPath
    tableView.deselectRow(at: indexPath, animated: false)
  }

}

extension MyProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let image = info[.originalImage] as! UIImage
    self.userImageView.image = image
    self.dismiss(animated: true, completion: nil)
  }

}

extension MyProfileViewController: ProfileDetailViewControllerDelegate {
  
  func edit(_ value: String, for field: InfoField) {
    switch field {
    case .username:
      userInfo?.username = value
    case .email:
      userInfo?.email = value
    case .babyName:
      userInfo?.babyName = value.isEmpty ? "Not decided yet" : value
    case .statusMessage:
      userInfo?.statusMessage = value
    case .bio:
      userInfo?.bio = value
    }
    
    profileTableView.reloadRows(at: [selectedIndexPath!], with: .automatic)
  }
  
}
