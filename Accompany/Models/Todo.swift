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
  
  //retrieves the array of items stored on disk, if there are any, and returns them.
  static func loadTodos() -> [Todo]? {
    guard let codedTodos = try? Data(contentsOf: archiveURL) else { return nil }
    let propertyListDecoder = PropertyListDecoder()
    return try? propertyListDecoder.decode(Array<Todo>.self, from: codedTodos)
  }
  
  //save it to a disk
  static func saveToDos(_ todos: [Todo]) {
    let propertyListEncoder = PropertyListEncoder()
    let codedToDos = try? propertyListEncoder.encode(todos)
    try? codedToDos?.write(to: archiveURL, options: .noFileProtection)
  }
  
  //given a different title property, since the cell will need to display this property.
  static func loadSampleToDos() -> [Todo] {
    let todo1 = Todo(title: "Ask Medical History", isCompleted: false, note: "test1")
    let todo2 = Todo(title: "MTHFR Gene Testing", isCompleted: true, note: "test2")
    let todo3 = Todo(title: "Nutrition Counseling & Patient Instructions (D3 Testing)", isCompleted: false, note: "test test")
    let todo4 = Todo(title: "First Ultrasound", isCompleted: true, note: "testestetset")
    return [todo1, todo2, todo3, todo4]
  }
  
}
