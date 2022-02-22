//
//  DatabaseManager.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-21.
//

import Firebase

struct DatabaseManager {
  
  static let shared = DatabaseManager()
  
  let db = Firestore.firestore()
  
  private init() { }
  
  public func fetchTodos() async throws -> [Todo] {
    
    do {
      
      let userRef = db.collection("users").document("0q10PmtadQcrXmlsa90EavdbuEf1")
      let snapshot = try await userRef.collection("todo_lists").document("nsuX06bRYkcESOLbps3X").collection("todos").getDocuments()

      return snapshot.documents.map { d in
        return Todo(id: d.documentID, title: d["title"] as? String ?? "", isCompleted: d["is_completed"] as? Bool ?? false, note: d["description"] as? String ?? "")
      }
      
    } catch {
      print("Error: \(error)")
      throw error
    }
    
  }
  
}
