//
//  TitleLabel.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-16.
//

import UIKit

class TitleLabel: UILabel {

  override init(frame: CGRect) {
    super.init(frame: .zero)
  }
  
  convenience init(title: String) {
    self.init(frame: .zero)
    self.translatesAutoresizingMaskIntoConstraints = false
    self.text = title
    self.font = UIFont(name: "SimpleBoy", size: 30)
    self.textColor = #colorLiteral(red: 0.9921568627, green: 0.3882352941, blue: 0.5333333333, alpha: 1)
    self.textAlignment = .center
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}