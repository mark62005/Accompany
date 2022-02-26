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
        Todo(id: "3", title: "Nutrition Counseling & Patient Instructions (D3 Testing)", isCompleted: false, note: "Type notes"),
        Todo(id: "4", title: "First Ultrasound", isCompleted: false, note: "Type notes"),
        Todo(id: "5", title: "Prenatal examination and  Blood tests", isCompleted: false, note: "Type notes"),
        Todo(id: "6", title: "Neisseria gonorrhoeae test & Chlamydia trachomatis test", isCompleted: false, note: "Type notes"),
        Todo(id: "7", title: "Pap smear, Human papilloma virus", isCompleted: false, note: "Type notes"),
        Todo(id: "8", title: "Cytomegalovirus screening", isCompleted: false, note: "Type notes"),
        Todo(id: "9", title: "Diabetes test", isCompleted: false, note: "Type notes"),
        Todo(id: "10", title: "NHI Regular blood screening for the first trimester", isCompleted: false, note: "Type notes"),
        Todo(id: "11", title: "Spinal muscular atrophy", isCompleted: false, note: "Type notes"),
        Todo(id: "12", title: "Thyroid function tests", isCompleted: false, note: "Type notes"),
        Todo(id: "13", title: "Fragile X syndrome", isCompleted: false, note: "Type notes") ,
        Todo(id: "14", title: "Toxoplasmosis screening", isCompleted: false, note: "Type notes"),
        Todo(id: "15", title: "pregnant woman physical fitnessd", isCompleted: false, note: "Type notes"),
        Todo(id: "16", title: "Non-invasive Prenatal test", isCompleted: false, note: "Type notes"),
        Todo(id: "17", title: "Maternal blood Down’s syndrome screening for the first trimester", isCompleted: false, note: "Type notes"),
        Todo(id: "18", title: "Preeclampsia risk assessment", isCompleted: false, note: "Type notes")
      ]),
      TodoList(id: "2", trimester: .secondTrimester, todos: [
        Todo(id: "19", title: "Maternal blood Down’s syndrome screening", isCompleted: false, note: "Type notes"),
        Todo(id: "20", title: "Health education consultation for prenatal check-up  ", isCompleted: false, note: "Type notes"),
        Todo(id: "21", title: "Amniocentesis, Amniotic fluid", isCompleted: false, note: "Type notes"),
        Todo(id: "22", title: "Premature birth risk assessment", isCompleted: false, note: "Type notes"),
        Todo(id: "23", title: "Anomaly Scan", isCompleted: false, note: "Type notes"),
        Todo(id: "24", title: "Seasonal influenza vaccination ", isCompleted: false, note: "Type notes"),
        Todo(id: "25", title: "Syphilis", isCompleted: false, note: "Type notes"),
        Todo(id: "26", title: "Gestational diabetes screening", isCompleted: false, note: "Type notes")
      ]),
      TodoList(id: "3", trimester: .thirdTrimester, todos: [
        Todo(id: "27", title: "Gestational diabetes reexamination", isCompleted: false, note: "Type notes"),
        Todo(id: "28", title: "Pregnant woman physical fitness", isCompleted: false, note: "Type notes"),
        Todo(id: "29", title: "Nutrition consultation", isCompleted: false, note: "Type notes"),
        Todo(id: "30", title: "Diphtheria and tetanus toxoid with acellular pertussis vaccination", isCompleted: false, note: "Type notes"),
        Todo(id: "31", title: "Fetal growth assessment", isCompleted: false, note: "Type notes"),
        Todo(id: "32", title: "Fetal ultrasound test", isCompleted: false, note: "Type notes"),
        Todo(id: "33", title: "Fetal movement record", isCompleted: false, note: "Type notes"),
        Todo(id: "34", title: "Fetal  health monitoring", isCompleted: false, note: "Type notes"),
        Todo(id: "35", title: "Fetal monitor", isCompleted: false, note: "Type notes"),
        Todo(id: "36", title: "Prenatal blood and urine examination  ", isCompleted: false, note: "Type notes"),
        Todo(id: "37", title: "GBS (Group B Streptococcus test)", isCompleted: false, note: "Type notes")
      ]),
      TodoList(id: "4", trimester: .after, todos: [
        Todo(id: "38", title: "Pertussis vaccination", isCompleted: false, note: "Type notes"),
        Todo(id: "39", title: "Pap smear", isCompleted: false, note: "Type notes"),
        Todo(id: "40", title: "HPV vaccination ", isCompleted: false, note: "Type notes"),
        Todo(id: "41", title: "HPV screening", isCompleted: false, note: "Type notes"),
        Todo(id: "42", title: "Family planning", isCompleted: false, note: "Type notes"),
      ]),
    ]
  }
  
  static func getTodos(of trimester: Trimester, from todoLists: [TodoList]) -> [Todo]? {
    return todoLists.filter { $0.trimester == trimester }.first?.todos
  }
  
}
