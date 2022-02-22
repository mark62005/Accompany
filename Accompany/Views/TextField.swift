//
//  TextField.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-21.
//

import UIKit

class TextField: UITextField {
  
  enum Color {
    case red, purple, black, grey
  }
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
  }

  convenience init(text: String?, color: Color = .grey) {
    self.init(frame: .zero)
    self.text = text
    self.font = .systemFont(ofSize: 16, weight: .regular)
    self.backgroundColor = .white
    self.textAlignment = .left
    self.contentVerticalAlignment = .fill
    self.layer.cornerRadius = 10
    self.translatesAutoresizingMaskIntoConstraints = false
    
    if let text = text {
      self.text = text
    }
    
    switch color {
    case .red:
      self.textColor = #colorLiteral(red: 0.9921568627, green: 0.3882352941, blue: 0.5333333333, alpha: 1)
    case .purple:
      self.textColor = #colorLiteral(red: 0.5490196078, green: 0.4588235294, blue: 0.968627451, alpha: 1)
    case .black:
      self.textColor = #colorLiteral(red: 0.2078431373, green: 0.2039215686, blue: 0.2235294118, alpha: 1)
    case.grey:
      self.textColor = #colorLiteral(red: 0.631372549, green: 0.631372549, blue: 0.631372549, alpha: 1)
    }
  
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
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
