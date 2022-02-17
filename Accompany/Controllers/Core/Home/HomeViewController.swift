//
//  HomeViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-04.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
  
  let accompanyTitleLabel = AccompanyTitleLabel()
  let welcomeTitleLabel = WelcomeTitleLabel()

 
  let button1 : UIButton = {
    let button1 = UIButton()
  button1.setTitle("1st Trimester", for: .normal)
  button1.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
  button1.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.3882352941, blue: 0.5333333333, alpha: 1)
  button1.layer.cornerRadius = 16
  button1.addTarget(self, action: #selector(goToTodoList(_:)), for: .touchUpInside)
    
    return button1
    
  }()
  
  
 
  let button2 : UIButton = {
    let button2 = UIButton()
    button2.setTitle("2nd Trimester", for: .normal)
    button2.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    button2.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.3882352941, blue: 0.5333333333, alpha: 1)
    button2.layer.cornerRadius = 16
    button2.addTarget(self, action: #selector(goToTodoList(_:)), for: .touchUpInside)
    
    return button2
    
  }()
  
  
  let button3 : UIButton = {
    let button3 = UIButton()
    button3.setTitle("3rd Trimester", for: .normal)
    button3.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    button3.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.3882352941, blue: 0.5333333333, alpha: 1)
    button3.layer.cornerRadius = 16
    button3.addTarget(self, action: #selector(goToTodoList(_:)), for: .touchUpInside)
    
    return button3
    
  }()
  
  
  let button4 : UIButton = {
    let button4 = UIButton()
    button4.setTitle("After", for: .normal)
    button4.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    button4.backgroundColor = #colorLiteral(red: 0.5490196078, green: 0.4039215686, blue: 0.968627451, alpha: 1)
    button4.layer.cornerRadius = 16
    button4.addTarget(self, action: #selector(goToTodoList(_:)), for: .touchUpInside)
    
    return button4
  }()
  
  let notifyTableView: UITableView = {
    let notifyTableView = UITableView()
    notifyTableView.register(NoteCell.self, forCellReuseIdentifier: "NoteCellIdentifier")
    notifyTableView.layer.cornerRadius = 10
    
    return notifyTableView
  }()
  
  let stopWatchView: UIButton = {
    let stopWatchView = UIButton()
    stopWatchView.setImage(UIImage(named: "stopwatch-icon.png"), for: .normal)
    stopWatchView.backgroundColor = .white
    stopWatchView.layer.cornerRadius = 15
    stopWatchView.translatesAutoresizingMaskIntoConstraints = false
    stopWatchView.addTarget(self, action: #selector(gotoStopWatch(_:)), for: .touchUpInside)
    
    return stopWatchView
  }()
  
  var todos = [NoteTodo]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    
    
    // fetch todos
    todos = NoteTodo.loadSampleToDos()
    
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
    view.addSubview(stopWatchView)
    
    
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
    
    stopWatchView.snp.makeConstraints { make in
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-30)
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
      make.width.equalTo(30)
      make.height.equalTo(35)
    }

}
  
  private func setupNavButtonArray() {
    
    let stackView = UIStackView(arrangedSubviews: [button1, button2, button3, button4])
    
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
    if button == button1 {
      todoListVC.todoListTitleLabel.text = "1st Trimester"
      
    } else if button == button2 {
      todoListVC.todoListTitleLabel.text = "2nd Trimester"

    } else if button == button3 {
      todoListVC.todoListTitleLabel.text = "3rd Trimester"
      
    } else {
      todoListVC.todoListTitleLabel.text = "After"
    }
    
  
  navigationController?.pushViewController(todoListVC, animated: true)
  
    
  }
  
  @objc func gotoStopWatch(_ button: UIButton) {
    
  }
  
 

}

extension HomeViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todos.count
  }
  
  
}

extension HomeViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCellIdentifier", for: indexPath) as! NoteCell
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







//  private func setupNavButton() {
//    let button = UIButton()
//    button.translatesAutoresizingMaskIntoConstraints = false
//    button.setTitle("Go to TodoList", for: .normal)
//    button.setTitleColor(.black, for: .normal)
//    button.backgroundColor = .white
//    button.addTarget(self, action: #selector(goToTodoList(_:)), for: .touchUpInside)
//
//    view.addSubview(button)
//
//    button.snp.makeConstraints { make in
//      make.top.equalTo(view.safeAreaLayoutGuide).offset(0)
//      make.left.equalTo(view.safeAreaLayoutGuide).offset(5)
//    }
//
//
//  }


//    let trackTitleLabel = trackTitleLabel()
//    let stackView = UIStackView(arrangedSubviews: [welcomeTitleLabel, trackTitleLabel])
//
//      stackView.axis = .vertical
//      stackView.alignment = .fill
//      stackView.distribution = .fill
//      stackView.spacing = 2

//    stackView.snp.makeConstraints { make in
//      make.top.equalTo(accompanyTitleLabel.snp.bottom).offset(0)
//      make.left.equalTo(view.safeAreaLayoutGuide).offset(45)
//      make.right.equalTo(view.safeAreaLayoutGuide).offset(-45)
//
//
//  }
