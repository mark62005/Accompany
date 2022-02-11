//
//  HomeViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-04.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let firstTrimester = FirstTrimesterLabel()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TodoCell.self, forCellReuseIdentifier: "ToDoCellIdentifier")
        tableView.layer.cornerRadius = 20
        
        return tableView
    }()
    
   var toDos = [Todo]()
  

  override func viewDidLoad() {
    super.viewDidLoad()
      
      view.backgroundColor = #colorLiteral(red: 1, green: 0.9019607843, blue: 0.8832569771, alpha: 1)
      view.addSubview(firstTrimester)
      view.addSubview(tableView)
      
      toDos = Todo.loadSampleToDos()
      
      firstTrimester.snp.makeConstraints { (make) -> Void in
          make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
          make.left.equalTo(view.safeAreaLayoutGuide).offset(80)
          make.right.equalTo(view.safeAreaLayoutGuide).offset(-80)
      }
      
          tableView.delegate = self
          tableView.dataSource = self
      
          
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                          target: self,
                                                          action: #selector(didTapAdd))
//      self.navigationItem.leftBarButtonItem = self.editButtonItem
      
 
  }
    
    @objc func didTapAdd() {
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier", for: indexPath) as! TodoCell
        let toDo = toDos[indexPath.row]
        cell.update(with: toDo)
        cell.isCompleteButton.setImage(UIImage(systemName: "circle"), for: .normal)
        cell.isCompleteButton.addTarget(self, action: #selector(checkMarkButtonClicked(sender:)), for: .touchUpInside)
        cell.showsReorderControl = true
        return cell
        
    }
    
    @objc func checkMarkButtonClicked( sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            sender.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        }
        else {
            sender.isSelected = true
            sender.setImage(UIImage(systemName: "circle"), for: .normal)
        }
            
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
        // 1. update model
            toDos.remove(at: indexPath.row)
        // 2. update view
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // 1. update model
            let toDo = Todo(title: "")
            toDos.insert(toDo, at: 0)
            // 2. update view
            tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print(#function)
        // update model
        let toDoToMove = toDos[sourceIndexPath.row]
        toDos.remove(at: sourceIndexPath.row)
        toDos.insert(toDoToMove, at: destinationIndexPath.row)
        tableView.reloadData()
    }

    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
     

}
