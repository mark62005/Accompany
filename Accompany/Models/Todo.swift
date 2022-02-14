//
//  Todo.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-10.
//

import Foundation

struct ToDo: Codable {
  
  static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  static let archiveURL = documentsDirectory.appendingPathComponent("toDos").appendingPathExtension("plist")
  
  var id = UUID()
  var title: String
  var isCompleted: Bool = false
  var note: String?
  
//  init(title: String) {
//      self.title = title
//  }
  
  //retrieves the array of items stored on disk, if there are any, and returns them.
  static func loadToDos() -> [ToDo]? {
    guard let codedToDos = try? Data(contentsOf: archiveURL) else { return nil }
    let propertyListDecoder = PropertyListDecoder()
    return try? propertyListDecoder.decode(Array<ToDo>.self, from: codedToDos)
  }
  
  //save it to a disk
  static func saveToDos(_ toDos: [ToDo]) {
    let propertyListEncoder = PropertyListEncoder()
    let codedToDos = try? propertyListEncoder.encode(toDos)
    try? codedToDos?.write(to: archiveURL, options: .noFileProtection)
  }
  
  //given a different title property, since the cell will need to display this property.
  static func loadSampleToDos() -> [ToDo] {
    let toDo1 = ToDo(title: "Ask Medical History", isCompleted: false, note: "test1")
    let toDo2 = ToDo(title: "MTHFR Gene Testing", isCompleted: true, note: "test2")
    let toDo3 = ToDo(title: "Nutrition Counseling & Patient Instructions (D3 Testing)", isCompleted: false, note: "test test")
    let toDo4 = ToDo(title: "First Ultrasound", isCompleted: true, note: "testestetset")
    return [toDo1, toDo2, toDo3, toDo4]
  }
  
}
        

