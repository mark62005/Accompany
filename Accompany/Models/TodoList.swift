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
  
  var id = UUID()
  var trimester: Trimester
  var todos: [Todo]?
  
  static func loadSampleTodoLists() -> [TodoList] {
    return [
      TodoList(trimester: .firstTrimester, todos: [
        Todo(title: "Ask Medical History", isCompleted: false, note: "Type notes"),
        Todo(title: "MTHFR Gene Testing", isCompleted: false, note: "Type notes"),
        Todo(title: "Nutrition Counseling & Patient Instructions (D3 Testing)", isCompleted: false, note: "Type notes")
      ]),
      TodoList(trimester: .secondTrimester, todos: [
        Todo(title: "Maternal blood Down’s syndrome screening for the second trimester", isCompleted: false, note: "Type notes"),
        Todo(title: "Health education consultation for prenatal check-up  ", isCompleted: false, note: "Type notes"),
        Todo(title: "Amniocentesis, Amniotic fluid", isCompleted: false, note: "Type notes")
      ]),
      TodoList(trimester: .thirdTrimester, todos: [
        Todo(title: "Gestational diabetes reexamination", isCompleted: false, note: "Type notes"),
        Todo(title: "Pregnant woman physical fitness", isCompleted: false, note: "Type notes"),
        Todo(title: "Nutrition consultation", isCompleted: false, note: "Type notes")
      ]),
      TodoList(trimester: .after, todos: [
        Todo(title: "Pertussis vaccination", isCompleted: false, note: "Type notes"),
        Todo(title: "Pap smear", isCompleted: false, note: "Type notes"),
        Todo(title: "HPV vaccination ", isCompleted: false, note: "Type notes")
      ]),
    ]
  }
  
  static func getTodos(of trimester: Trimester, from todoLists: [TodoList]) -> [Todo]? {
    return todoLists.filter { $0.trimester == trimester }.first?.todos
  }
  
}
