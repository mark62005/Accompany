//
//  Todo.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-10.
//

import Foundation

struct Todo: Codable {
  var id = UUID()
  var title: String
  var isCompleted: Bool = false
    
    init(title: String) {
        self.title = title
    }
    
    //retrieves the array of items stored on disk, if there are any, and returns them.
    static func loadToDos() -> [Todo]? {
        guard let codedToDos = try? Data(contentsOf: archiveURL) else { return nil }
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<Todo>.self, from: codedToDos)
    }
    
    //save it to a disk
    static func saveToDos(_ toDos: [Todo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(toDos)
        try? codedToDos?.write(to: archiveURL, options: .noFileProtection)
    }
    
    //given a different title property, since the cell will need to display this property.
    static func loadSampleToDos() -> [Todo] {
        let toDo1 = Todo(title: "Ask Medical History")
        let toDo2 = Todo(title: "MTHFR Gene Testing")
        let toDo3 = Todo(title: "Nutrition Counseling & Patient Instructions (D3 Testing)")
        let toDo4 = Todo(title: "First Ultrasound")
        return [toDo1, toDo2, toDo3, toDo4]

    }
    
    static let documentsDirectory =
    FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let archiveURL =
    documentsDirectory.appendingPathComponent("toDos").appendingPathExtension("plist")
    
    
   
}
        

