//
//  firstTrimesterLabel.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-10.
//

import UIKit
import SnapKit

class TodoListTitleLabel: UILabel {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  convenience init() {
    self.init(frame: .zero)
    self.textColor = #colorLiteral(red: 0.9940978885, green: 0.3898795247, blue: 0.532279253, alpha: 1)
    self.textAlignment = .center
    self.font = UIFont(name: "SimpleBoy", size: 40)
  
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
