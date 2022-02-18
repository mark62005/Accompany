//
//  HomeViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-04.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
  
  let accompanyTitleLabel = TitleLabel(title: "Accompany", size: .large, color: .red)
  let welcomeTitleLabel = TitleLabel(title: "Welcome back user!", size: .mini, color: .black)

  let firstTrimesterButton = PrimaryButton(title: Trimester.firstTrimester.rawValue)
  let secondTrimesterButton = PrimaryButton(title: Trimester.secondTrimester.rawValue)
  let thirdTrimesterButton = PrimaryButton(title: Trimester.thirdTrimester.rawValue)
  let afterButton = SecondaryButton(title: Trimester.after.rawValue)
  
  let notifyTableView: UITableView = {
    let notifyTableView = UITableView()
    notifyTableView.register(TodoCell.self, forCellReuseIdentifier: TodoCell.identifier)
    notifyTableView.layer.cornerRadius = 10
    
    return notifyTableView
  }()
  
  let stopWatchButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "stopwatch-icon.png"), for: .normal)
    button.backgroundColor = .white
    button.layer.cornerRadius = 15
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(gotoStopWatch(_:)), for: .touchUpInside)
    
    return button
  }()
  
  var todos = [Todo]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    
    // TODO: fetch todos
    todos = Todo.loadSampleToDos()
    
    configureTableView()
    setupNavButtonArray()
    setupLayout()
   
  }
  
  private func configureTableView() {
    notifyTableView.delegate = self
    notifyTableView.dataSource = self
 
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    view.addSubview(notifyTableView)
    
    notifyTableView.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(welcomeTitleLabel.snp.bottom).offset(30)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(40)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-40)
      make.height.equalTo(200)
    }
  
  }
  
  private func setupLayout() {
    view.addSubview(accompanyTitleLabel)
    view.addSubview(welcomeTitleLabel)
    view.addSubview(stopWatchButton)
    
    accompanyTitleLabel.snp.makeConstraints { make in
      make.top.equalTo(view).offset(60)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(40)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-40)
    }
    
    welcomeTitleLabel.snp.makeConstraints { make in
      make.top.equalTo(accompanyTitleLabel.snp.bottom).offset(0)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(50)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-50)
    }
    
    stopWatchButton.snp.makeConstraints { make in
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-30)
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
      make.width.equalTo(30)
      make.height.equalTo(35)
    }

}
  
  private func setupNavButtonArray() {
    let buttons = [firstTrimesterButton, secondTrimesterButton, thirdTrimesterButton, afterButton]
    buttons.forEach { $0.addTarget(self, action: #selector(goToTodoList(_:)), for: .touchUpInside) }
    
    let stackView = UIStackView(arrangedSubviews: buttons)
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 25
          
    view.addSubview(stackView)
      
    stackView.snp.makeConstraints { make in
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-60)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(90)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-90)
    }
    
  }
  
  @objc func goToTodoList(_ button: UIButton) {
    let todoListVC = TodoListViewController()
    
    switch button {
    case firstTrimesterButton:
      todoListVC.todoListTitleLabel.text = Trimester.firstTrimester.rawValue
    case secondTrimesterButton:
      todoListVC.todoListTitleLabel.text = Trimester.secondTrimester.rawValue
    case thirdTrimesterButton:
      todoListVC.todoListTitleLabel.text = Trimester.thirdTrimester.rawValue
    case afterButton:
      todoListVC.todoListTitleLabel.text = Trimester.after.rawValue
    default:
      return
    }
    
    navigationController?.pushViewController(todoListVC, animated: true)
  
  }
  
  @objc func gotoStopWatch(_ button: UIButton) {
    print("Stop watch tapped")
  }
  
}

extension HomeViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todos.count
  }
  
}

extension HomeViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.identifier, for: indexPath) as! TodoCell
    let toDo = todos[indexPath.row]
    cell.update(with: toDo)
    cell.isCompleteButton.setImage(UIImage(systemName: "circle"), for: .normal)
    cell.isCompleteButton.addTarget(self, action: #selector(checkMarkButtonClicked(sender:)), for: .touchUpInside)
    
    return cell
    
  }
  
  @objc func checkMarkButtonClicked( sender: UIButton) {
    if sender.isSelected {
      sender.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
    }
    else {
      sender.setImage(UIImage(systemName: "circle"), for: .normal)
    }
    // toggle between true and false
    sender.isSelected.toggle()
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
    // 1. update model
      todos.remove(at: indexPath.row)
    // 2. update view
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
  
}
