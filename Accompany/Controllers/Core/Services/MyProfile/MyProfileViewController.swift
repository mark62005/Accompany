//
//  MyProfileViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-17.
//

import UIKit
import SnapKit
import QuartzCore

class MyProfileViewController: UIViewController {
  
  let titleLabel = TitleLabel(title: Services.myProfile.description, size: .medium, color: .red)
  let userImageView = UIImageView(image: UIImage(systemName: "photo.on.rectangle"))
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 25, weight: .bold)
    label.textAlignment = .center
    
    return label
  }()
  
  let emailLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 20, weight: .regular)
    label.textAlignment = .center
    
    return label
  }()
  
  let bioTextField = TextField(text: "Introduce yourself")

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    
    userImageView.layer.cornerRadius = 10
    
    navigationItem.rightBarButtonItem = editButtonItem
    
    setupLayout()
    
    setPlaceholderText()
  }
  
  
  private func setPlaceholderText() {
    nameLabel.text = "Username"
    emailLabel.text = "example@email.com"
//    bioLabel.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
  }
  
  private func setupLayout() {
    
    view.addSubview(titleLabel)
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
    }
    
    view.addSubview(userImageView)
    
    userImageView.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(6)
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.4)
      make.height.equalTo(userImageView.snp.width).multipliedBy(0.8)
    }
    
    // stack view?
    let nameAndEmailStack = VStack(arrangedSubviews: [nameLabel, emailLabel])
    nameAndEmailStack.spacing = 5
    
//    let vStack = VStack(arrangedSubviews: [userImageView, nameAndEmailStack])
//    vStack.alignment = .center
    
    view.addSubview(nameAndEmailStack)
    
    nameAndEmailStack.snp.makeConstraints { make in
      make.top.equalTo(userImageView.snp.bottom).offset(10)
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.8)
    }
    
    view.addSubview(bioTextField)
    
    bioTextField.snp.makeConstraints { make in
      make.top.equalTo(nameAndEmailStack.snp.bottom).offset(20)
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.9)
      make.height.equalTo(bioTextField.snp.width).multipliedBy(0.9)
      make.left.equalTo(bioTextField.snp.left).offset(5)
    }
    
  }
  
  
//  private func setupImage() {
//    view.addSubview(userImageView)
//
//    userImageView.snp.makeConstraints { make in
//      make.top.equalTo(titleLabel.snp.bottom).offset(6)
//      make.centerX.equalTo(view)
//      make.width.equalTo(view.snp.width).multipliedBy(0.4)
//      make.height.equalTo(userImageView.snp.width).multipliedBy(1)
//    }
//  }
  
}
