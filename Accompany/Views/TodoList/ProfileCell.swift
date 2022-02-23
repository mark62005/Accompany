//
//  ProfileCell.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-22.
//

import UIKit

class ProfileCell: UITableViewCell {
  
  static let identifier = "ProfileCell"
  
  class TextField: UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    override var intrinsicContentSize: CGSize {
      return .init(width: 0, height: 44)
    }
    
    
  }
  
  let textField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    
    return textField
    
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    addSubview(textField)
    
    textField.snp.makeConstraints { make in
      make.edges.equalTo(0).inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func update(with info: Info) {
    self.textField.placeholder = info.text
  }

}
