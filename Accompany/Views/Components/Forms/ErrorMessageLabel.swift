//
//  ErrorMessageLabel.swift
//  FirestoreDemo
//
//  Created by Mark Wong on 2022-02-18.
//

import UIKit

class ErrorMessageLabel: UILabel {

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.translatesAutoresizingMaskIntoConstraints = false
    self.font = .systemFont(ofSize: 17, weight: .regular)
    self.textColor = .red
    self.numberOfLines = 0
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
