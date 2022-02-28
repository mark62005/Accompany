//
//  Todo.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-16.
//

import Foundation
import FirebaseDatabase

struct Todo {
  
  var id: String = ""
  var title: String
  var isCompleted: Bool = false
  var note: String?
  
  var dictionary: [String: Any] {
    return [
      "id": id,
      "title": title,
      "is_completed": isCompleted,
      "note": note ?? ""
    ]
  }
  
}
  
extension Todo: Codable {
  
  init?(dictionary: [String: Any]) {
    guard let id = dictionary["id"] as? String,
          let title = dictionary["title"] as? String,
          let isCompleted = dictionary["is_completed"] as? Bool else { return nil }
    
    let note = dictionary["note"] as? String ?? ""
    
    self.init(id: id, title: title, isCompleted: isCompleted, note: note)
  }
  
}

