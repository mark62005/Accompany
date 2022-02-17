//
//  WelcomeTitleLabel.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-13.
//

import Foundation
import UIKit
import SnapKit

class WelcomeTitleLabel: UILabel {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  
  convenience init() {
    self.init(frame: .zero)
    self.text = "Welcome back, (username)"
    self.textColor = #colorLiteral(red: 0.2078431373, green: 0.2039215686, blue: 0.2235294118, alpha: 1)
    self.textAlignment = .center
    self.font = UIFont.boldSystemFont(ofSize: 20.0)
    
    
  }

  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}



