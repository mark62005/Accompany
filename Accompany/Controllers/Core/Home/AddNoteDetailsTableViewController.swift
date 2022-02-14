//
//  SemesterDetailsTableViewController.swift
//  Accompany
//
//  Created by Kelbin David on 2022-02-10.
//

import UIKit
import SnapKit

protocol AddNoteDetailsTableViewControllerDelegate {
  func add(todo: ToDo)
  func edit(todo: ToDo)
}

class AddNoteDetailsTableViewController: UITableViewController {
  
  var saveBarButton: UIBarButtonItem = {
    let barButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
    return barButton
  }()
  
  var todo: ToDo?
  var delegate: AddNoteDetailsTableViewControllerDelegate?
  var isCompleteButton: UIButton?
  var toDoTitleTextField: UITextField?
  var noteTextView: UITextView?
  let buttonIndexPath = IndexPath(row: 0, section: 0)
  let noteIndexPath = IndexPath(row: 0, section: 1)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.rightBarButtonItem = saveBarButton
    if todo != nil {
      navigationItem.title = "Edit To Do"
    } else {
      navigationItem.title = "Add To Do"
    }
    tableView.register(AddNoteCellOneTableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.register(AddNoteCellTwoTableViewCell.self, forCellReuseIdentifier: "cell2")
    tableView.isUserInteractionEnabled = true
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self, selector: #selector(textViewDidChange), name: UITextView.textDidChangeNotification, object: nil)
    updateSaveButton()
  }
  
  @objc func saveButtonTapped(){
    let isComplete = isCompleteButton!.isSelected
    let toDoTitle = toDoTitleTextField!.text!
    let note = noteTextView?.text ?? ""
    let newToDo = ToDo(title: toDoTitle, isCompleted: isComplete, note: note)
    if todo != nil {
      delegate?.edit(todo: newToDo)
    } else {
      delegate?.add(todo: newToDo)
    }
    self.navigationController?.popViewController(animated: true)
  }

  // MARK: - Table view data source

  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 0:
      return "BASIC INFORMATIONS"
    case 1:
      return "NOTES"
    default:
      return ""
    }
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddNoteCellOneTableViewCell
      cell.contentView.isUserInteractionEnabled = false
      cell.isCompleteButton.addTarget(self, action: #selector(isCompleteButtonTapped), for: .touchUpInside)
      isCompleteButton = cell.isCompleteButton
      isCompleteButton?.isSelected = todo?.isCompleted == nil ? false : todo!.isCompleted
      cell.toDoTextField.addTarget(self, action: #selector(toDoTitleTextFieldEditingChanged), for: .editingChanged)
      toDoTitleTextField = cell.toDoTextField
      cell.toDoTextField.text = todo?.title
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! AddNoteCellTwoTableViewCell
      cell.contentView.isUserInteractionEnabled = false
      noteTextView = cell.noteTextView
      noteTextView?.text = todo?.note
      return cell
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath {
    case buttonIndexPath:
      return 60
    case noteIndexPath:
      return 300
    default:
      return UITableView.automaticDimension
    }
  }
  
  func updateSaveButton(){
    let title = toDoTitleTextField?.text ?? ""
    saveBarButton.isEnabled = !title.isEmpty
  }
  
  @objc func isCompleteButtonTapped(sender: UIButton){
    updateSaveButton()
    sender.isSelected.toggle()
    toDoTitleTextField?.becomeFirstResponder()
  }
  
  @objc func toDoTitleTextFieldEditingChanged(sender: UITextField){
    updateSaveButton()
  }
  
  @objc func textViewDidChange(_ notif: NSNotification){
    guard notif.object is UITextView else { return }
    updateSaveButton()
  }
}
