//
//  NoteTodo.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-14.
//

import Foundation

struct NoteTodo: Codable {
  
  static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  static let archiveURL = documentsDirectory.appendingPathComponent("toDos").appendingPathExtension("plist")
  
  var id = UUID()
  var title: String
  var isCompleted: Bool = false
    
  init(title: String) {
      self.title = title
  }
  
  //retrieves the array of items stored on disk, if there are any, and returns them.
  static func loadNoteToDos() -> [NoteTodo]? {
    guard let codedToDos = try? Data(contentsOf: archiveURL) else { return nil }
    let propertyListDecoder = PropertyListDecoder()
    return try? propertyListDecoder.decode(Array<NoteTodo>.self, from: codedToDos)
  }
  
  //save it to a disk
  static func saveToDos(_ toDos: [NoteTodo]) {
    let propertyListEncoder = PropertyListEncoder()
    let codedToDos = try? propertyListEncoder.encode(toDos)
    try? codedToDos?.write(to: archiveURL, options: .noFileProtection)
  }
  
  //given a different title property, since the cell will need to display this property.
  static func loadSampleToDos() -> [NoteTodo] {
    let toDo1 = NoteTodo(title: "To do 1")
    let toDo2 = NoteTodo(title: "To do 2")
    let toDo3 = NoteTodo(title: "To do 3")
    
    return [toDo1, toDo2, toDo3]
  }
  
}
        


