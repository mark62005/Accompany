//
//  TextField.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-04.
//

import UIKit

class TextField: UITextField {

  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  convenience init() {
    self.init(frame: .zero)
  
    
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
