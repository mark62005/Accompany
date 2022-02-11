//
//  TodoCell.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-10.
//

import Foundation
import UIKit
import SnapKit


class TodoCell: UITableViewCell {
    
  let isCompleteButton = UIButton()

  let titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.numberOfLines = 0
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    return titleLabel
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
      
    let stackView = UIStackView(arrangedSubviews: [isCompleteButton, titleLabel])
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 10
    
    contentView.addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.centerX.equalTo(contentView)
      make.centerY.equalTo(contentView)
      make.left.equalTo(contentView).offset(10)
      make.right.equalTo(contentView).offset(10)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func update(with toDo: Todo) {
    self.titleLabel.text = toDo.title
  }
    
}

