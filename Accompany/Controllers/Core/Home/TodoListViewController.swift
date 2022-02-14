//
//  TodoListViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-11.
//

import UIKit
import SnapKit

class TodoListViewController: UIViewController, AddNoteDetailsTableViewControllerDelegate {
  
  func add(todo: ToDo) {
    todos.append(todo)
    tableView.insertRows(at: [IndexPath(row: todos.count - 1, section: 0)], with: .automatic)
  }
  
  func edit(todo: ToDo) {
    if let selectedIndexPath = tableView.indexPathForSelectedRow {
      todos[selectedIndexPath.row] = todo
      tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
    }
  }

  let todoListTitleLabel = TodoListTitleLabel()
  
  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(TodoCell.self, forCellReuseIdentifier: "ToDoCellIdentifier")
    tableView.layer.cornerRadius = 20
    return tableView
  }()
  
  var todos = [ToDo]()

  override func viewDidLoad() {
    super.viewDidLoad()
    prepareLabel(label: self.todoListTitleLabel, string: "1", superScript: "st")
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9019607843, blue: 0.8832569771, alpha: 1)
    view.addSubview(todoListTitleLabel)
    view.addSubview(tableView)
    
    // fetch todos
    todos = ToDo.loadSampleToDos()
    todoListTitleLabel.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(80)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-80)
    }
    configureTableView()
        
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    
  }
  
  private func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
  }
    
  @objc func didTapAdd() {
    let addnoteController = AddNoteDetailsTableViewController()
    addnoteController.delegate = self
    navigationController?.pushViewController(addnoteController, animated: false)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.snp.makeConstraints { (make) -> Void in
      make.centerX.equalTo(view)
      make.centerY.equalTo(view)
      make.width.equalTo(345)
      make.height.equalTo(380)
    }
  }
  
}

extension TodoListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todos.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier", for: indexPath) as! TodoCell
    let toDo = todos[indexPath.row]
    
    // configure cell
    cell.update(with: toDo)
    cell.isCompleteButton.isSelected = toDo.isCompleted
    cell.showsReorderControl = true
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 70
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let addNoteTVC = AddNoteDetailsTableViewController()
    addNoteTVC.todo = todos[indexPath.row]
    addNoteTVC.delegate = self
    navigationController?.pushViewController(addNoteTVC, animated: true)
  }
}

extension TodoListViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
    // 1. update model
      todos.remove(at: indexPath.row)
    // 2. update view
      tableView.deleteRows(at: [indexPath], with: .fade)
    } else if editingStyle == .insert {
      // 1. update model
      let toDo = ToDo(title: "")
      todos.insert(toDo, at: 0)
      // 2. update view
      tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
  }
  
  func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//    print(#function)
    let toDoToMove = todos[sourceIndexPath.row]
    // update model
    todos.remove(at: sourceIndexPath.row)
    todos.insert(toDoToMove, at: destinationIndexPath.row)
    // update view
    tableView.reloadData()
  }
  
  func prepareLabel(label: UILabel, string: String, superScript: String){
    let font = UIFont(name: "SimpleBoy", size: 50)
    let fontSuper = UIFont(name: "SimpleBoy", size: 20)
    let fontExtension = label.text![label.text!.index(label.text!.startIndex,offsetBy: 3)..<label.text!.index(label.text!.endIndex, offsetBy: 0)]
    let attributedString = NSMutableAttributedString(string: string + superScript + fontExtension, attributes: [NSAttributedString.Key.font:font!])
    attributedString.setAttributes([NSAttributedString.Key.font:fontSuper!, NSAttributedString.Key.baselineOffset:10], range: NSRange(location: string.count, length: superScript.count))
    print()
    label.attributedText = attributedString

  }
}
