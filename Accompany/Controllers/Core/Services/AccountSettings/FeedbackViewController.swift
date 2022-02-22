//
//  FeedbackViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-17.
//

import UIKit

class FeedbackViewController: CustomTableController {
  
  let submitButton = PrimaryButton(title: "Submit")
  
  let textField = TextField(text: "If you have any problems or suggestions, please let us know.")

  override func viewDidLoad() {
    super.viewDidLoad()
    
    titleLabel.text = "Feedback"
    
    submitButton.addTarget(self, action: #selector(submitData(_:)), for: .touchUpInside)

    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    
    setupLayout()
  }
  
  @objc func submitData(_ sender: UIButton) {
    //MARK: Save it to the database
    
    textField.text = ""
  }
  
  override func setupLayout() {
    view.addSubview(titleLabel)
     
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
    }
    
    view.addSubview(textField)
    
    textField.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(15)
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.8)
      make.height.equalTo(textField.snp.width).multipliedBy(0.7)
    }
    
    view.addSubview(submitButton)
    
    submitButton.snp.makeConstraints { make in
      make.top.equalTo(textField.snp.bottom).offset(25)
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.3)
    }

  }
   
}
