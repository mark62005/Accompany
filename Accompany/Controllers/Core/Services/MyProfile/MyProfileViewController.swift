//
//  MyProfileViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-17.
//

import UIKit
import SnapKit

class MyProfileViewController: UIViewController {
    let titleLabel = TitleLabel(title: Services.myProfile.description, size: .medium)
 
  let userImageView = UIImageView(image: UIImage(systemName: "photo.on.rectangle"))
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 30, weight: .bold)
    label.textAlignment = .center
    
    return label
  }()
  
  let emailLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 25, weight: .regular)
    label.textAlignment = .center
    
    return label
  }()
  
  let bioLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 16, weight: .regular)
    label.numberOfLines = 0
    
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    title = Services.myProfile.description
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    
    navigationItem.rightBarButtonItem = editButtonItem
    setupLayout()
    
    setPlaceholderText()
  }
  
  private func setPlaceholderText() {
    nameLabel.text = "Username"
    emailLabel.text = "example@email.com"
    bioLabel.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
  }
  
  private func setupLayout() {
    setupImage()
    
    // stack view?
    let nameAndEmailStack = VStack(arrangedSubviews: [nameLabel, emailLabel])
    nameAndEmailStack.spacing = 5
//    nameAndEmailStack.addSubview(nameLabel)
//    nameAndEmailStack.addSubview(emailLabel)
    
    let vStack = VStack(arrangedSubviews: [titleLabel, userImageView, nameAndEmailStack, bioLabel])
    vStack.alignment = .center
    
    view.addSubview(vStack)
    vStack.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.8)
    }
  }
  
  private func setupImage() {
//    userImageView.snp.makeConstraints { make in
//      make.height.equalTo(view.snp.height).multipliedBy(0.2)
//    }
    userImageView.snp.makeConstraints { make in
      make.height.equalTo(150)
      make.width.equalTo(self.userImageView.snp.height)
    }
//    userImageView.heightAnchor.constraint(equalTo: userImageView.widthAnchor).isActive = true
//    userImageView.setContentHuggingPriority(UILayoutPriority(0), for: .vertical)
  }
  
}
