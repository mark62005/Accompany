//
//  DatePickerTableViewCell.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-24.
//

import UIKit
import SnapKit

class DatePickerTableViewCell: UITableViewCell {

  static let identifier = "DatePickerTableViewCell"
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 18, weight: .regular)
    label.textColor = .black
    label.setContentHuggingPriority(UILayoutPriority(252), for: .horizontal)
    
    return label
  }()
   
  let datePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    datePicker.translatesAutoresizingMaskIntoConstraints = false
    // ....
    
    return datePicker
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    let hStack = VStack(arrangedSubviews: [titleLabel, datePicker])
    contentView.addSubview(hStack)
    
    // TODO: set constraints...
    hStack.snp.makeConstraints { make in
      make.edges.equalTo(contentView).inset(UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10))
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
