//
//  AddNoteTableViewCell.swift
//  Accompany
//
//  Created by Kelbin David on 2022-02-10.
//

import UIKit
import SnapKit

class AddNoteCellOneTableViewCell: UITableViewCell {

  let isCompleteButton: UIButton = {
    let circle = UIImage(systemName: "circle")
    let button = UIButton()
    button.setImage(circle, for: .normal)
    button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
    button.isUserInteractionEnabled = true
    button.isSelected = false
    return button
  }()
  
  let toDoTextField: UITextField = {
    let textField = UITextField()
    textField.textAlignment = .left
    textField.font = .boldSystemFont(ofSize: 30)
    textField.placeholder = "Title"
    textField.isUserInteractionEnabled = true
    return textField
  }()
  
  let addNoteTVC = AddNoteDetailsTableViewController()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addSubview(isCompleteButton)
    addSubview(toDoTextField)
    isCompleteButton.snp.makeConstraints{(make) in
      make.top.equalTo(0)
      make.left.equalTo(0).offset(15)
      make.width.height.equalTo(50)
    }
    
    toDoTextField.snp.makeConstraints{(make) in
      make.top.right.equalTo(0)
      make.left.equalTo(isCompleteButton.snp.right).offset(15)
      make.height.equalTo(50)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
