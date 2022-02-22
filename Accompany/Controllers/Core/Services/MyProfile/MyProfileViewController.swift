//
//  MyProfileViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-17.
//

import UIKit
import SnapKit

class MyProfileViewController: CustomTextViewController {
  
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

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    
    titleLabel.text = Services.myProfile.description

    userImageView.layer.cornerRadius = 10
    
    navigationItem.rightBarButtonItem = editButtonItem
    
    setupLayout()
    
    setPlaceholderText()
    
//    self.dismissKeyboard()
  }
  
  private func setPlaceholderText() {
    nameLabel.text = "Username"
    emailLabel.text = "example@email.com"
    textView.text = "Introduce Yourself"
  }
  
  func setupLayout() {
    
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
    
    view.addSubview(nameAndEmailStack)
    
    nameAndEmailStack.snp.makeConstraints { make in
      make.top.equalTo(userImageView.snp.bottom).offset(10)
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.8)
    }
    
    view.addSubview(textView)
    
    textView.snp.makeConstraints { make in
      make.top.equalTo(nameAndEmailStack.snp.bottom).offset(20)
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.9)
      make.height.equalTo(textView.snp.width).multipliedBy(0.9)
      make.left.equalTo(textView.snp.left).offset(5)
    }
    
  }
  
}


