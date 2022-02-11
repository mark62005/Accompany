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
        
        let stackView = UIStackView()
        stackView.addArrangedSubview(isCompleteButton)
        stackView.addArrangedSubview(titleLabel)
        contentView.addSubview(stackView)
        
        
        isCompleteButton.snp.makeConstraints { make in
            make.top.equalTo(stackView).offset(10)
            make.left.equalTo(stackView).offset(20)
            make.width.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView).offset(10)
            make.left.equalTo(stackView).offset(60)
        }
        
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

