//
//  TrackTitleLabel.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-13.
//

import Foundation
import UIKit
import SnapKit

class trackTitleLabel: UILabel {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  
  convenience init() {
    self.init(frame: .zero)
    self.text = "Let's track your baby!"
    self.textColor = #colorLiteral(red: 0.631372549, green: 0.631372549, blue: 0.631372549, alpha: 1)
    self.textAlignment = .center
    self.font = UIFont.boldSystemFont(ofSize: 20.0)
    
    
  }

  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

