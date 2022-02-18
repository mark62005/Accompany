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
    
    return label
  }()
  
  let emailLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 25, weight: .regular)
    
    return label
  }()
  
  let bioLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 16, weight: .regular)
    
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    title = Services.myProfile.description
    view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.7450980392, blue: 0.6941176471, alpha: 1)
    
    navigationItem.rightBarButtonItem = editButtonItem
    setupLayout()
  }
  
  private func setupLayout() {
    let nameAndEmailVStack = VStack(arrangedSubviews: [nameLabel, emailLabel])
    let vStack = VStack(arrangedSubviews: [titleLabel, userImageView, nameAndEmailVStack, bioLabel])
    
    view.addSubview(vStack)
    vStack.snp.makeConstraints { make in
      make.edges.equalTo(view.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 30, left: 30, bottom: 40, right: 30))
    }
  }
  
}
