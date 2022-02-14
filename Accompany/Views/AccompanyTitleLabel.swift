//
//  AccompanyTitleLabel.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-13.
//

import Foundation
import UIKit
import SnapKit

class AccompantTitleLabel: UILabel {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  
  convenience init() {
    self.init(frame: .zero)
    self.textColor = #colorLiteral(red: 0.9921568627, green: 0.3882352941, blue: 0.5333333333, alpha: 1)
    self.text = "Accompany"
    self.textAlignment = .center
    self.font = UIFont(name: "SimpleBoy", size: 70)
    
    
  }

  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
