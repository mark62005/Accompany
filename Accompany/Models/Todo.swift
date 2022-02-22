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
  
  static var lorem = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
  
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
    let todo1 = Todo(title: "Ask Medical History", isCompleted: false, note: lorem)
    let todo2 = Todo(title: "MTHFR Gene Testing", isCompleted: true, note: lorem)
    let todo3 = Todo(title: "Nutrition Counseling & Patient Instructions (D3 Testing)", isCompleted: false, note: lorem)
    let todo4 = Todo(title: "First Ultrasound", isCompleted: true, note: lorem)
    
    return [todo1, todo2, todo3, todo4]
  }
  
}
