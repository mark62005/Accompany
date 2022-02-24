//
//  HomeViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-04.
//

import UIKit
import SnapKit
import FirebaseAuth

class HomeViewController: UIViewController {

  let accompanyTitleLabel = TitleLabel(title: "Accompany", size: .large, color: .red)
  let welcomeTitleLabel = TitleLabel(title: "Welcome back user!", size: .mini, color: .black)

  let firstTrimesterButton = PrimaryButton(title: Trimester.firstTrimester.rawValue)
  let secondTrimesterButton = PrimaryButton(title: Trimester.secondTrimester.rawValue)
  let thirdTrimesterButton = PrimaryButton(title: Trimester.thirdTrimester.rawValue)
  let afterButton = SecondaryButton(title: Trimester.after.rawValue)
  
  let notifyTableView: UITableView = {
    let notifyTableView = UITableView(frame: .zero, style: .plain)
    notifyTableView.register(TodoCell.self, forCellReuseIdentifier: TodoCell.identifier)
    notifyTableView.register(TodoHeaderView.self, forHeaderFooterViewReuseIdentifier: TodoHeaderView.identifier)
    notifyTableView.isUserInteractionEnabled = true
    notifyTableView.layer.cornerRadius = 10
    notifyTableView.translatesAutoresizingMaskIntoConstraints = false
    
    return notifyTableView
  }()
  
  let bgCircleView = ImageView()
  
  var todos = [Todo]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
 
    bgCircleView.image = UIImage(named: "grey-bg")
    
    // sign user out - for debugging
    try? Auth.auth().signOut()
    
    // TODO: fetch todos
    Task {
      do {
        todos = try await DatabaseManager.shared.fetchTodos()
        
        configureTableView()
        setupLayout()
      } catch {
        print("Error: \(error)")
      }
    }
    
    
    UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self])
           .textColor = UIColor.black
    UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self])
      .font = UIFont.systemFont(ofSize: 18)
    
    self.navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "Home Page", style: .plain, target: nil, action: nil)
  }
  
  private func configureTableView() {
    notifyTableView.delegate = self
    notifyTableView.dataSource = self
    notifyTableView.sectionHeaderTopPadding = .zero
  }
  
  private func setupLayout() {
    
    view.addSubview(accompanyTitleLabel)
    
    accompanyTitleLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.centerX.equalTo(view)
    }
    
    view.addSubview(welcomeTitleLabel)
    
    welcomeTitleLabel.snp.makeConstraints { make in
      make.top.equalTo(accompanyTitleLabel.snp.bottom).offset(3)
      make.centerX.equalTo(view)
    }

    view.addSubview(notifyTableView)
       
    notifyTableView.backgroundColor = .white
     
    notifyTableView.snp.makeConstraints { (make) -> Void in
      make.centerX.equalTo(view)
      make.top.equalTo(welcomeTitleLabel.snp.bottom).offset(20)
      make.width.equalTo(view.snp.width).multipliedBy(0.8)
      make.height.equalTo(view.snp.width).multipliedBy(0.5)
   
    }
    
    view.addSubview(bgCircleView)

    bgCircleView.snp.makeConstraints { make in
      make.centerX.equalTo(view)
      make.top.equalTo(notifyTableView.snp.bottom).offset(20)
      make.left.equalTo(view.safeAreaLayoutGuide)
      make.right.equalTo(view.safeAreaLayoutGuide)
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(3)
    }
    
    let buttons = [firstTrimesterButton, secondTrimesterButton, thirdTrimesterButton, afterButton]
    buttons.forEach { $0.addTarget(self, action: #selector(goToTodoList(_:)), for: .touchUpInside) }
    
    let stackView = UIStackView(arrangedSubviews: buttons)
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 15
          
    view.addSubview(stackView)
    
    stackView.snp.makeConstraints { make in
      make.centerX.equalTo(view)
      make.top.equalTo(bgCircleView.snp.top).offset(45)
      make.width.equalTo(view.snp.width).multipliedBy(0.45)
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
  
}

extension HomeViewController: UITableViewDelegate {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return tableView.dequeueReusableHeaderFooterView(withIdentifier: TodoHeaderView.identifier) as? TodoHeaderView
  }
    
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 30
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todos.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 42
  }
  
}
  
extension HomeViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.identifier, for: indexPath) as! TodoCell
    let toDo = todos[indexPath.row]
    cell.delegate = self
    cell.update(with: toDo)
    cell.backgroundColor = .white
    
    return cell
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let addNoteTVC = ToDoFormTableViewController()
    addNoteTVC.todo = todos[indexPath.row]
    addNoteTVC.delegate = self
    navigationController?.pushViewController(addNoteTVC, animated: true)
    
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
    // 1. update model
      todos.remove(at: indexPath.row)
    // 2. update view
      tableView.deleteRows(at: [indexPath], with: .fade)
    } else if editingStyle == .insert {
      // 1. update model
      let todo = Todo(id: "0", title: "")
      todos.insert(todo, at: 0)
    // 2. update view
      notifyTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
    
  }
  
}

extension HomeViewController: TodoCellDelegate {
  
  func isCompleteButtonTapped(sender: TodoCell) {
    if let indexPath = notifyTableView.indexPath(for: sender) {
//      var todo = todos[indexPath.row]
//      todo.isCompleted.toggle()
//
      // update model
      todos[indexPath.row].isCompleted.toggle()
      todos.remove(at: indexPath.row)
      //notifyTableView.reloadRows(at: [indexPath], with: .automatic)
      notifyTableView.reloadData()
      // TODO: save changes to database
    }
  }
  
}

extension HomeViewController: ToDoFormTableViewControllerDelegate {
  
  func add(todo: Todo) {
    todos.append(todo)
    notifyTableView.insertRows(at: [IndexPath(row: todos.count - 1, section: 0)], with: .automatic)
    
  }
  
  func edit(todo: Todo) {
    if let selectedIndexPath = notifyTableView.indexPathForSelectedRow {
      todos[selectedIndexPath.row] = todo
      notifyTableView.reloadRows(at: [selectedIndexPath], with: .automatic)
    }
    
  }
  
}
