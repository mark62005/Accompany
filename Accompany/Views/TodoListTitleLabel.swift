//
//  firstTrimesterLabel.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-10.
//

import UIKit
import SnapKit

class TodoListTitleLabel: UILabel {
  
  // initiate
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  convenience init() {
    self.init(frame: .zero)
    self.textColor = .purple
    self.textAlignment = .center
    self.font = UIFont(name: "SimpleBoy", size: 40)
    }
    
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
}
