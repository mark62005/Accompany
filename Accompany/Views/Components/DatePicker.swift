//
//  DatePicker.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-27.
//

import UIKit

class DatePicker: UIDatePicker {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  convenience init() {
    self.init(frame: .zero)
    self.translatesAutoresizingMaskIntoConstraints = false
    self.preferredDatePickerStyle = .compact
    self.datePickerMode = .date
    self.backgroundColor = .white
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
