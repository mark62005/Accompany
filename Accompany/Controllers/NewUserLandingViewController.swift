//
//  NewUserLandingViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-27.
//

import UIKit
import SnapKit
import Firebase

class NewUserLandingViewController: UIViewController {
  
  let titleLabel = TitleLabel(title: nil, size: .small)

  let babyNameFormControl = FormControlVStack(field: .babyName)
  let statusMessageFormControl = FormControlVStack(field: .statusMessage)
  let bioFormControl = FormControlVStack(field: .bio)
  let dateOfPregnancyFormControl = FormControlVStack(field: .dateOfPregnancy)
  let dueDateFormControl = FormControlVStack(field: .dueDate)

  let confirmButton = PrimaryButton(title: "Confirm")
  
  var user: User!

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    
    babyNameFormControl.formTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    
    setUpLayout()
    updateConfirmButtonState()
  }
 
  private func setUpLayout() {
    
//    view.addSubview(tableView)
//    tableView.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
//    
//    tableView.snp.makeConstraints { make in
//      make.centerX.equalTo(view)
//      make.centerY.equalTo(view)
//      make.width.equalTo(view.snp.width).multipliedBy(0.8)
//      make.height.equalTo(view.snp.height).multipliedBy(0.5)
//    }
//    
//    view.addSubview(confirmButton)
//    confirmButton.snp.makeConstraints { make in
//      make.top.equalTo(tableView.snp.bottom).offset(10)
//      make.centerX.equalTo(view)
//      make.width.equalTo(tableView.snp.width).multipliedBy(0.7)
//      make.height.equalTo(tableView.snp.height).multipliedBy(0.3)
//    }
    
    let vStack = VStack(arrangedSubviews: [titleLabel, babyNameFormControl, statusMessageFormControl, bioFormControl, dateOfPregnancyFormControl, dueDateFormControl, confirmButton])
    vStack.spacing = 5
    vStack.distribution = .fillEqually

    view.addSubview(vStack)
    vStack.snp.makeConstraints { make in
      make.centerX.equalTo(view)
      make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
      make.width.equalTo(view.snp.width).multipliedBy(0.8)
      make.height.equalTo(view.snp.height).multipliedBy(0.8)
    }
  }
  
  @objc func textFieldEditingChanged() {
    updateConfirmButtonState()
  }
  
  @objc func confirmButtonTapped() {
    Task {
      do {
        let babyName = babyNameFormControl.formTextField.trimmedText!
        let statusMessage = statusMessageFormControl.formTextField.trimmedText ?? ""
        let bio = bioFormControl.formTextField.trimmedText ?? ""
        let dateOfPregnancy = dateOfPregnancyFormControl.datePicker.date
        let dueDate = dueDateFormControl.datePicker.date
        
        let newUser = AccompanyUser(
          id: user.uid,
          info: Info(
            username: user.displayName!,
            email: user.email!,
            babyName: babyName,
            dateOfPregnancy: dateOfPregnancy,
            dueDate: dueDate,
            statusMessage: statusMessage,
            bio: bio
          )
        )
        
        try await DatabaseManager.shared.insertNewUser(with: newUser)
        
        DispatchQueue.main.async {
          self.dismiss(animated: true, completion: nil)
        }

      } catch {
        print("Error: \(error)")
      }
    }
  }
   
  private func updateConfirmButtonState() {
    let babyName = babyNameFormControl.formTextField.trimmedText ?? ""
    confirmButton.isEnabled = !babyName.isEmpty
  }
    
}
