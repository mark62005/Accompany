//
//  TodoList.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-16.
//

import Foundation
import FirebaseDatabase

enum Trimester: String, CaseIterable, CustomStringConvertible {
  
  case firstTrimester = "1st Trimester"
  case secondTrimester = "2nd Trimester"
  case thirdTrimester = "3rd Trimester"
  case after = "After"
  
  var description: String {
    switch self {
    case .firstTrimester:
      return "first_trimester"
    case .secondTrimester:
      return "second_trimester"
    case .thirdTrimester:
      return "third_trimester"
    case .after:
      return "after"
    }
  }
}

struct TodoList {
  
  var trimester: Trimester
  var todos = [Todo]()
  
  var dictionary: [String: Any] {
    return [
      "id": trimester.description,
      "todos": todos.map { [$0.id: $0] }
    ]
  }
  
  static func getDefaultTodos(of trimester: Trimester) -> [Todo] {
    switch trimester {
    case .firstTrimester:
      return [
        Todo(title: "Ask Medical History"),
        Todo(title: "MTHFR Gene Testing"),
        Todo(title: "Nutrition Counseling & Patient Instructions (D3 Testing)"),
        Todo(title: "First Ultrasound"),
        Todo(title: "Prenatal examination and  Blood tests"),
        Todo(title: "Neisseria gonorrhoeae test & Chlamydia trachomatis test"),
        Todo(title: "Pap smear, Human papilloma virus"),
        Todo(title: "Cytomegalovirus screening"),
        Todo(title: "Diabetes test"),
        Todo(title: "NHI Regular blood screening for the first trimester"),
        Todo(title: "Spinal muscular atrophy"),
        Todo(title: "Thyroid function tests"),
        Todo(title: "Fragile X syndrome"),
        Todo(title: "Toxoplasmosis screening"),
        Todo(title: "pregnant woman physical fitnessd"),
        Todo(title: "Non-invasive Prenatal test"),
        Todo(title: "Maternal blood Down’s syndrome screening for the first trimester"),
        Todo(title: "Preeclampsia risk assessment")
      ]
    case .secondTrimester:
      return [
        Todo(title: "Maternal blood Down’s syndrome screening"),
        Todo(title: "Health education consultation for prenatal check-up"),
        Todo(title: "Amniocentesis, Amniotic fluid"),
        Todo(title: "Anomaly Scan"),
        Todo(title: "Seasonal influenza vaccination"),
        Todo(title: "Syphilis"),
        Todo(title: "Gestational diabetes screening")
      ]
    case .thirdTrimester:
      return [
        Todo(title: "Gestational diabetes reexamination"),
        Todo(title: "Pregnant woman physical fitness"),
        Todo(title: "Nutrition consultation"),
        Todo(title: "Diphtheria and tetanus toxoid with acellular pertussis vaccination"),
        Todo(title: "Fetal growth assessment"),
        Todo(title: "Fetal ultrasound test"),
        Todo(title: "Fetal movement record"),
        Todo(title: "Fetal  health monitoring"),
        Todo(title: "Fetal monitor"),
        Todo(title: "Prenatal blood and urine examination"),
        Todo(title: "GBS (Group B Streptococcus test)")
      ]
    case .after:
      return [
        Todo(title: "Pertussis vaccination"),
        Todo(title: "Pap smear"),
        Todo(title: "HPV vaccination"),
        Todo(title: "HPV screening"),
        Todo(title: "Family planning")
      ]
    }
  }
  
  mutating func add(_ todo: Todo) {
    todos.append(todo)
  }
  
}

extension TodoList {
  
  init?(_ snapshot: DataSnapshot, of trimester: Trimester) {
    
    var todos = [Todo]()
    let dict = snapshot.value as! [String: Any]
    for value in dict.values {
      if let todoDict = value as? [String: Any],
         let todo = Todo(dictionary: todoDict) {
        todos.append(todo)
      }
    }
        
    self.init(trimester: trimester, todos: todos)
    
  }
  
}
