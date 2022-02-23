//
//  Todo.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-16.
//

import Foundation

struct Todo: Codable {
  
  static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  static let archiveURL = documentsDirectory.appendingPathComponent("toDos").appendingPathExtension("plist")
  
  var id = UUID()
  var title: String
  var isCompleted: Bool = false
  var note: String?
  
  //given a different title property, since the cell will need to display this property.
  static func loadSampleToDos() -> [Todo] {
    let todo1 = Todo(title: "Ask Medical History", isCompleted: false, note: "Type notes")
    let todo2 = Todo(title: "MTHFR Gene Testing", isCompleted: false, note: "Type notes")
    let todo3 = Todo(title: "Nutrition Counseling & Patient Instructions (D3 Testing)", isCompleted: false, note: "Type notes")
    let todo4 = Todo(title: "First Ultrasound", isCompleted: false, note: "Type notes")
    
    return [todo1, todo2, todo3, todo4]
  }
  
}
