//
//  FormControlHStack.swift
//  FirestoreDemo
//
//  Created by Mark Wong on 2022-02-18.
//

import UIKit
import SnapKit

class FormControlVStack: UIStackView {
  
  enum Field: CustomStringConvertible {
    
    case firstName, lastName, email, password, babyName, statusMessage, bio, dateOfPregnancy, dueDate
    
    var description: String {
      switch self {
      case .firstName:
        return "First Name"
      case .lastName:
        return "Last Name"
      case .email:
        return "Email"
      case .password:
        return "Password"
      case .statusMessage:
        return "Status Message"
      case .bio:
        return "Bio"
      case .babyName:
        return "Baby Name"
      case .dateOfPregnancy:
        return "Date of Pregnancy"
      case .dueDate:
        return "Due Date"
      }
    }
    
  }

  private let label: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 17, weight: .regular)
    label.numberOfLines = 0
    label.setContentHuggingPriority(UILayoutPriority(252), for: .vertical)
    
    return label
  }()
  
  let formTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.leftViewMode = .always
    textField.textAlignment = .left
    textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 0))
    textField.layer.masksToBounds = true
    textField.autocorrectionType = .no
    textField.autocapitalizationType = .none
    textField.returnKeyType = .continue
    textField.borderStyle = .roundedRect
    textField.layer.borderWidth = 1.0
    textField.layer.borderColor = UIColor.secondaryLabel.cgColor
    textField.layer.cornerRadius = 10
    
    return textField
  }()
  
  let datePicker = DatePicker()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  convenience init(field: Field) {
    self.init(frame: .zero)
     
    self.translatesAutoresizingMaskIntoConstraints = false
    self.axis = .vertical
    self.distribution = .fill
    self.alignment = .leading
    self.spacing = 5
    self.snp.makeConstraints { make in
      make.width.equalTo(100)
      make.height.equalTo(20)
    }
    
    configureLabel(with: field)
    self.addArrangedSubview(label)
    
    if field == .dateOfPregnancy || field == .dueDate {
      addDatePicker(with: field)
    } else {
      addTextField(with: field)
    }
    
    label.snp.makeConstraints { make in
      make.width.equalTo(self.snp.width).multipliedBy(0.25)
    }
  }
  
  private func configureLabel(with field: Field) {
    if field == .statusMessage || field == .bio {
      self.label.text = "\(field.description) (Optional)"
    } else {
      self.label.text = field.description
    }
  }
  
  private func addDatePicker(with field: Field) {
    // TODO: configuration for max and min date?
    configureDatePicker()
    if field == .dateOfPregnancy {
      datePicker.maximumDate = NSCalendar.current.date(byAdding: .day, value: -1, to: Date())
    } else if field == .dueDate {
      datePicker.minimumDate = NSCalendar.current.date(byAdding: .day, value: +1, to: Date())
    }
    self.addArrangedSubview(datePicker)
  }
  
  private func configureDatePicker() {
    datePicker.backgroundColor = nil
    datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
  }
  
  @objc func datePickerValueChanged(_ datePicker: DatePicker) {
    print(datePicker.date.description)
  }
  
  private func addTextField(with field: Field) {
    configureTextField(field: field)
    self.addArrangedSubview(formTextField)
  }
  
  private func configureTextField(field: Field) {
    
    if field == .email {
      // email validation
      
    } else if field == .password {
      formTextField.isSecureTextEntry = true
    }
    
    formTextField.placeholder = field.description
    formTextField.addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
    
  }
  
  @objc func textEditingChanged(_ textField: UITextField) {
    print(textField.trimmedText!)
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension UITextField {
  
  var trimmedText: String? {
    return self.text?.trimmingCharacters(in: .whitespacesAndNewlines)
  }
  
}
