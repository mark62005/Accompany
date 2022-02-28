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
  case babyName = "Baby Name"
  case dateOfPregnancy = "Date of Pregnancy"
  case statusMessage = "Status"
  case bio = "Bio"
 
 
}

class MyProfileViewController: CustomTextViewController {
  
  let profileTableView: UITableView = {
    let profileTableView = UITableView()
    profileTableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
    profileTableView.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    profileTableView.separatorStyle = .none
    profileTableView.translatesAutoresizingMaskIntoConstraints = false
    
    return profileTableView
  }()
  
  let userImageView = UIImageView(image: UIImage(systemName: "person.fill"))
  
  let datePickerCell = DatePickerTableViewCell()
  
  var userInfo: Info {
    return DatabaseManager.shared.currentUser.info
  }
  var selectedIndexPath: IndexPath?
  
  let datePickerIndexPath = IndexPath(row: 3, section: 0)

 
  override func viewDidLoad() {
    super.viewDidLoad()
    
    titleLabel.text = Services.myProfile.description
    
    addTapToImage()

    configTableView()
    setupLayout()
   
    self.navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "My Profile", style: .plain, target: nil, action: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    profileTableView.reloadData()
    
    fetchUserInfo()
  }
  
  // TODO: fetch user info from db
  private func fetchUserInfo() {
//    userInfo = DatabaseManager.shared.currentUser.info
  }
  
  func addTapToImage() {
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
    userImageView.isUserInteractionEnabled = true
    userImageView.addGestureRecognizer(tapGestureRecognizer)
    
    userImageView.contentMode = .scaleAspectFit
    userImageView.layer.borderWidth = 1.0
    userImageView.layer.masksToBounds = false
    userImageView.layer.borderColor = #colorLiteral(red: 1, green: 0.8831380575, blue: 0.9568627451, alpha: 1)
    userImageView.layer.cornerRadius = 60
    userImageView.clipsToBounds = true
    
  }
  
  @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
    
    let alert = UIAlertController(title: "Accompany Would Like to Access your Photos.", message: "Choose one way to upload photos", preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
      self.openCamera()
    }))
    alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (_) in
      self.openPhotoGallery()
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    
    self.present(alert, animated: true, completion: nil)
    
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
      make.width.equalTo(120)
      make.height.equalTo(120)
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
    return 6
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if indexPath == datePickerIndexPath {
    
      datePickerCell.datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
            
      return datePickerCell
    }
    
    else {
      let cell = profileTableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier, for: indexPath) as! ProfileCell
      
      switch indexPath.row {
      case 0:
        cell.update(with: userInfo.username, for: InfoField.username)
      case 1:
        cell.update(with: userInfo.email, for: InfoField.email)
      case 2:
        cell.update(with: userInfo.babyName, for: InfoField.babyName)
      case 3:
        // TODO:                                    date formatter
        cell.update(with: userInfo.dateOfPregnancy.description, for: InfoField.dateOfPregnancy)
      case 4:
        cell.update(with: userInfo.statusMessage, for: InfoField.statusMessage)
      default:
        cell.update(with: userInfo.bio, for: InfoField.bio)
      }
      
      return cell
    }
    
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if indexPath == datePickerIndexPath {
      return
    }
    
    else {
      let profileDetailVC = ProfileDetailViewController()
      profileDetailVC.delegate = self
      
//      guard let userInfo = userInfo else { return }
      
      switch indexPath.row {
      case 0:
        profileDetailVC.fieldValue = userInfo.username
      case 1:
        profileDetailVC.fieldValue = userInfo.email
      case 2:
        profileDetailVC.fieldValue = userInfo.babyName
      case 4:
        profileDetailVC.fieldValue = userInfo.statusMessage
      case 5:
        profileDetailVC.fieldValue = userInfo.bio
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
  
  @objc func datePickerValueChanged(_ datePicker: UIDatePicker) {
    DatabaseManager.shared.currentUser.info.dateOfPregnancy = datePicker.date
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
//    guard let userInfo = userInfo else { return }
    
    // TODO: update db
//    DatabaseManager.shared.currentUser.info = userInfo
    print("Current user: \(DatabaseManager.shared.currentUser.description)")
  }

}

extension MyProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    let image = info[.editedImage] as? UIImage
    self.userImageView.image = image
    self.dismiss(animated: true, completion: nil)
  }

}

extension MyProfileViewController: ProfileDetailViewControllerDelegate {
  
  func edit(_ value: String, for field: InfoField) {
    guard var currentUser = DatabaseManager.shared.currentUser else { return }
    
    switch field {
    case .username:
//      userInfo.username = value
      currentUser.info.username = value
    case .email:
//      userInfo.email = value
      currentUser.info.email = value
    case .babyName:
//      userInfo.babyName = value
      currentUser.info.babyName = value
    case .statusMessage:
//      userInfo.statusMessage = value
      currentUser.info.statusMessage = value
    case .bio:
//      userInfo.bio = value
      currentUser.info.bio = value
    default:
      return
    }
    
    print(currentUser.info.description)
    DatabaseManager.shared.currentUser = currentUser
    
    profileTableView.reloadRows(at: [selectedIndexPath!], with: .automatic)
  }
  
}
