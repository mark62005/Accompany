//
//  ProfileDetailViewController.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-22.
//

import UIKit

protocol ProfileDetailDelegate {
  
}

class ProfileDetailViewController: CustomTextViewController {
  
  var delegate: ProfileDetailDelegate?
  
//  let title: UILabel = {
//    let title = UILabel()
//    title.textAlignment = .center
//    title.text = "Edit Information"
//    title.textColor = .black
//    title.font = UIFont.systemFont(ofSize: 18)
//    title.translatesAutoresizingMaskIntoConstraints = false
//
//    return title
//  }()
  
  let confirmButton = OutlineButton(title: "Confirmation")
  
  var info: Info?

    override func viewDidLoad() {
        super.viewDidLoad()
      
      titleLabel.text = "Edit Information"
      textView.text = "Edit"
      
      confirmButton.addTarget(self, action: #selector(pressBtn(_:)), for: .touchUpInside)
      
      setupLayout()
      
    }
  
  @objc func pressBtn(_ sender: UIButton) {
    
  }
  
  func setupLayout() {
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.centerX.equalTo(view)
    }
    
    view.addSubview(textView)
    
    textView.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(30)
      make.width.equalTo(view.snp.width)
      make.height.equalTo(textView.snp.width).multipliedBy(0.3)
    }
    
    view.addSubview(confirmButton)
    
    confirmButton.snp.makeConstraints { make in
      make.top.equalTo(textView.snp.bottom).offset(20)
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.3)
      make.height.equalTo(confirmButton.snp.width).multipliedBy(0.3)
    }
  }
    
  

    

}
