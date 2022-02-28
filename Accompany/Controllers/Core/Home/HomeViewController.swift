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
  
  //TODO: Fetch username, and titlLabel text will be welcome back \(username)
  let welcomeTitleLabel = TitleLabel(title: "Welcome back!", size: .mini, color: .black)

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
  
  var todoLists = [Trimester:TodoList]()
  var currentTodos = [Todo]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // sign user out - for debugging
    try? Auth.auth().signOut()
    
    UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self])
           .textColor = UIColor.black
    UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self])
      .font = UIFont.systemFont(ofSize: 18)
    
    self.navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "Home Page", style: .plain, target: nil, action: nil)
    
    bgCircleView.image = UIImage(named: "grey-bg")
    
    configureTableView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    print(#function)
    
    // TODO: fetch todoLists
    fetchTodoLists()
    print("Current Todos: \(currentTodos.description)")
    
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    
    setupLayout()
    notifyTableView.reloadData()
  }
  
  private func fetchTodoLists() {
    guard let currentUser = DatabaseManager.shared.currentUser else { return }
    
    // fetch todolists
    todoLists = currentUser.todoLists
    
    // decide current trimester
    let currentTrimester = getCurrentTrimester(of: currentUser)
    print(currentTrimester.description)
    
    // assign current todos
    currentTodos = currentUser.todoLists[currentTrimester]!.todos
  }
  
  private func getCurrentTrimester(of currentUser: AccompanyUser) -> Trimester {
    // calculate which trimester
    guard let dueDate = currentUser.info.dueDate,
       let dateOfPregnancy = currentUser.info.dateOfPregnancy else {
         return .firstTrimester
    }
    
    let dateDifference = (dueDate - dateOfPregnancy).asDays()
    switch Double(dateDifference) / 7.0 {
    case Double(Int.min)..<14:
      return .after
    case 14..<29:
      return .thirdTrimester
    case 29..<41:
      return .secondTrimester
    default:
      return .firstTrimester
    }
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
      make.width.equalTo(view.snp.width).multipliedBy(0.84)
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
    guard let currentUser = DatabaseManager.shared.currentUser else { return }
    
    let todoListVC = TodoListViewController()
    switch button {
    case firstTrimesterButton:
      todoListVC.todoListTitleLabel.text = Trimester.firstTrimester.rawValue
      todoListVC.todos = currentUser.todoLists[.firstTrimester]!.todos
    case secondTrimesterButton:
      todoListVC.todoListTitleLabel.text = Trimester.secondTrimester.rawValue
      todoListVC.todos = currentUser.todoLists[.secondTrimester]!.todos
    case thirdTrimesterButton:
      todoListVC.todoListTitleLabel.text = Trimester.thirdTrimester.rawValue
      todoListVC.todos = currentUser.todoLists[.thirdTrimester]!.todos
    case afterButton:
      todoListVC.todoListTitleLabel.text = Trimester.after.rawValue
      todoListVC.todos = currentUser.todoLists[.after]!.todos
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
    return currentTodos.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 58
  }
  
}
  
extension HomeViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.identifier, for: indexPath) as! TodoCell
    
    let toDo = currentTodos[indexPath.row]
    
    cell.delegate = self
    cell.update(with: toDo)
    cell.backgroundColor = .white
    
    return cell
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let addNoteTVC = ToDoFormTableViewController()
    
    addNoteTVC.todo = currentTodos[indexPath.row]
    addNoteTVC.delegate = self
    navigationController?.pushViewController(addNoteTVC, animated: true)
    
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
    // 1. update model
      currentTodos.remove(at: indexPath.row)
    // 2. update view
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
  }
  
}

extension HomeViewController: TodoCellDelegate {
  
  func isCompleteButtonTapped(sender: TodoCell) {
    if let indexPath = notifyTableView.indexPath(for: sender) {
      var todo = currentTodos[indexPath.row]
      todo.isCompleted.toggle()

      // update model
      currentTodos[indexPath.row].isCompleted.toggle()

      notifyTableView.reloadRows(at: [indexPath], with: .automatic)
      // TODO: save changes to database
    }
  }
  
}


extension HomeViewController: ToDoFormTableViewControllerDelegate {

  func add(todo: Todo) { }

  func edit(todo: Todo) {
    if let selectedIndexPath = notifyTableView.indexPathForSelectedRow {
      currentTodos[selectedIndexPath.row] = todo
      notifyTableView.reloadRows(at: [selectedIndexPath], with: .automatic)
    }
  }

}

