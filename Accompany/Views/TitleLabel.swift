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

  convenience init() {
    self.init(frame: .zero)
    self.translatesAutoresizingMaskIntoConstraints = false
    self.font = UIFont(name: "SimpleBoy", size: 60)
    self.textColor = #colorLiteral(red: 0.9921568627, green: 0.3882352941, blue: 0.5333333333, alpha: 1)
  }
  
  convenience init(title: String) {
    self.init(frame: .zero)
    self.translatesAutoresizingMaskIntoConstraints = false
    self.text = title
    self.textAlignment = .center
    self.font = UIFont(name: "SimpleBoy", size: 45)
    self.textColor = #colorLiteral(red: 0.9921568627, green: 0.3882352941, blue: 0.5333333333, alpha: 1)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
