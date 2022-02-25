//
//  TodoList.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-16.
//

import Foundation

enum Trimester: String, CaseIterable {
  
  case firstTrimester = "1st Trimester"
  case secondTrimester = "2nd Trimester"
  case thirdTrimester = "3rd Trimester"
  case after = "After"
  
}

struct TodoList {
  
  var id: String
  var trimester: Trimester
  var todos: [Todo]?
  
  static func loadSampleTodoLists() -> [TodoList] {
    return [
      TodoList(id: "1", trimester: .firstTrimester, todos: [
        Todo(id: "1", title: "Ask Medical History", isCompleted: false, note: "Type notes"),
        Todo(id: "2", title: "MTHFR Gene Testing", isCompleted: false, note: "Type notes"),
        Todo(id: "3", title: "Nutrition Counseling & Patient Instructions (D3 Testing)", isCompleted: false, note: "Type notes")
      ]),
      TodoList(id: "2", trimester: .secondTrimester, todos: [
        Todo(id: "4", title: "Maternal blood Down’s syndrome screening for the second trimester", isCompleted: false, note: "Type notes"),
        Todo(id: "5", title: "Health education consultation for prenatal check-up  ", isCompleted: false, note: "Type notes"),
        Todo(id: "6", title: "Amniocentesis, Amniotic fluid", isCompleted: false, note: "Type notes")
      ]),
      TodoList(id: "3", trimester: .thirdTrimester, todos: [
        Todo(id: "7", title: "Gestational diabetes reexamination", isCompleted: false, note: "Type notes"),
        Todo(id: "8", title: "Pregnant woman physical fitness", isCompleted: false, note: "Type notes"),
        Todo(id: "9", title: "Nutrition consultation", isCompleted: false, note: "Type notes")
      ]),
      TodoList(id: "4", trimester: .after, todos: [
        Todo(id: "10", title: "Pertussis vaccination", isCompleted: false, note: "Type notes"),
        Todo(id: "11", title: "Pap smear", isCompleted: false, note: "Type notes"),
        Todo(id: "12", title: "HPV vaccination ", isCompleted: false, note: "Type notes")
      ]),
    ]
  }
  
  static func getTodos(of trimester: Trimester, from todoLists: [TodoList]) -> [Todo]? {
    return todoLists.filter { $0.trimester == trimester }.first?.todos
  }
  
}
