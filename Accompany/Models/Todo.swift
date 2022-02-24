//
//  Todo.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-16.
//

import Foundation

enum Cycle {
  case firstTrimester, secondTrimester, thirdTrimester, afterBirth
}


struct Todo: Codable {
  
  static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  static let archiveURL = documentsDirectory.appendingPathComponent("toDos").appendingPathExtension("plist")
  
  var id = UUID()
  var title: String
  var isCompleted: Bool = false
  var note: String?
  
  //given a different title property, since the cell will need to display this property.
  static func loadSampleToDos(_ trimester: Cycle) -> [Todo] {
    
    switch trimester {
    case .firstTrimester:
      let todo1 = Todo(title: "Ask Medical History", isCompleted: false, note: "Type notes")
      let todo2 = Todo(title: "MTHFR Gene Testing", isCompleted: false, note: "Type notes")
      let todo3 = Todo(title: "Nutrition Counseling & Patient Instructions (D3 Testing)", isCompleted: false, note: "Type notes")
      let todo4 = Todo(title: "First Ultrasound", isCompleted: false, note: "Type notes")
      let todo5 = Todo(title: "Prenatal examination and  Blood tests", isCompleted: false, note: "Type notes")
      let todo6 = Todo(title: "Neisseria gonorrhoeae test & Chlamydia trachomatis test", isCompleted: false, note: "Type notes")
      let todo7 = Todo(title: "Pap smear, Human papilloma virus", isCompleted: false, note: "Type notes")
      let todo8 = Todo(title: "Cytomegalovirus screening", isCompleted: false, note: "Type notes")
      let todo9 = Todo(title: "Diabetes test", isCompleted: false, note: "Type notes")
      let todo10 = Todo(title: "NHI Regular blood screening for the first trimester", isCompleted: false, note: "Type notes")
      let todo11 = Todo(title: "Spinal muscular atrophy", isCompleted: false, note: "Type notes")
      let todo12 = Todo(title: "Thyroid function tests", isCompleted: false, note: "Type notes")
      let todo13 = Todo(title: "Fragile X syndrome", isCompleted: false, note: "Type notes")
      let todo14 = Todo(title: "Toxoplasmosis screening", isCompleted: false, note: "Type notes")
      let todo15 = Todo(title: "pregnant woman physical fitnessd", isCompleted: false, note: "Type notes")
      let todo16 = Todo(title: "Non-invasive Prenatal test", isCompleted: false, note: "Type notes")
      let todo17 = Todo(title: "Maternal blood Down’s syndrome screening for the first trimester", isCompleted: false, note: "Type notes")
      let todo18 = Todo(title: "Preeclampsia risk assessment", isCompleted: false, note: "Type notes")
  
      return [todo1, todo2, todo3, todo4, todo5, todo6, todo7, todo8, todo9, todo10, todo11, todo12, todo13, todo14, todo15, todo16, todo17, todo18]
      
    case.secondTrimester:
      
      let todo19 = Todo(title: "Maternal blood Down’s syndrome screening for the second trimester", isCompleted: false, note: "Type notes")
      let todo20 = Todo(title: "Health education consultation for prenatal check-up  ", isCompleted: false, note: "Type notes")
      let todo21 = Todo(title: "Amniocentesis, Amniotic fluid", isCompleted: false, note: "Type notes")
      let todo22 = Todo(title: "Premature birth risk assessment", isCompleted: false, note: "Type notes")
      let todo23 = Todo(title: "Anomaly Scan", isCompleted: false, note: "Type notes")
      let todo24 = Todo(title: "Seasonal influenza vaccination ", isCompleted: false, note: "Type notes")
      let todo25 = Todo(title: "Syphilis", isCompleted: false, note: "Type notes")
      let todo26 = Todo(title: "Gestational diabetes screening", isCompleted: false, note: "Type notes")
     
      return [todo19, todo20, todo21, todo22, todo23, todo24, todo25, todo26]
      
    case.thirdTrimester:
      
      let todo27 = Todo(title: "Gestational diabetes reexamination", isCompleted: false, note: "Type notes")
      let todo28 = Todo(title: "Pregnant woman physical fitness", isCompleted: false, note: "Type notes")
      let todo29 = Todo(title: "Nutrition consultation", isCompleted: false, note: "Type notes")
      let todo30 = Todo(title: "Diphtheria and tetanus toxoid with acellular pertussis vaccination", isCompleted: false, note: "Type notes")
      let todo31 = Todo(title: "Fetal growth assessment", isCompleted: false, note: "Type notes")
      let todo32 = Todo(title: "Fetal ultrasound test", isCompleted: false, note: "Type notes")
      let todo33 = Todo(title: "Fetal movement record", isCompleted: false, note: "Type notes")
      let todo34 = Todo(title: "Fetal  health monitoring", isCompleted: false, note: "Type notes")
      let todo35 = Todo(title: "Fetal monitor", isCompleted: false, note: "Type notes")
      let todo36 = Todo(title: "Prenatal blood and urine examination  ", isCompleted: false, note: "Type notes")
      let todo37 = Todo(title: "GBS (Group B Streptococcus test", isCompleted: false, note: "Type notes")
      
      return [todo27, todo28, todo29, todo30, todo31, todo32, todo33, todo34, todo35, todo36, todo37]
      
    case.afterBirth:
      
      let todo38 = Todo(title: "Pertussis vaccination", isCompleted: false, note: "Type notes")
      let todo39 = Todo(title: "Pap smear", isCompleted: false, note: "Type notes")
      let todo40 = Todo(title: "HPV vaccination ", isCompleted: false, note: "Type notes")
      let todo41 = Todo(title: "HPV screening", isCompleted: false, note: "Type notes")
      let todo42 = Todo(title: "Family planning", isCompleted: false, note: "Type notes")
      
      return [todo38, todo39, todo40, todo41, todo42]
       
    }
  
  }
  
  
}
