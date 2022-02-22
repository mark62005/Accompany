//
//  TextField.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-21.
//

import UIKit

class TextField: UITextField {
  
  let padding = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 0)
  
  override open func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
  override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
  override open func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }

}
