//
//  HomeViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-04.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavButton()
  }
  
  private func setupNavButton() {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Go to TodoList", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.backgroundColor = .white
    button.addTarget(self, action: #selector(goToTodoList(_:)), for: .touchUpInside)
    
    view.addSubview(button)
    button.snp.makeConstraints { make in
      make.centerX.equalTo(view.safeAreaLayoutGuide)
      make.centerY.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  @objc func goToTodoList(_ button: UIButton) {
    let todoListVC = TodoListViewController()
    todoListVC.todoListTitleLabel.text = "1st Trimester"
    
    navigationController?.pushViewController(todoListVC, animated: true)
  }
  
}

