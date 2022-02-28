//
//  ProfileOption.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-22.
//
import Foundation
import FirebaseDatabase

struct Info {
  
  var username: String
  var email: String
  var babyName: String
  var dateOfPregnancy: Date?
  var dueDate: Date?
  var statusMessage: String = ""
  var bio: String = ""
  
  static func loadSampleInfo() -> Info {
    return Info(
      username: "Accompany",
      email: "accompany@email.com",
      babyName: "Not decided yet",
      dateOfPregnancy: nil,
      dueDate: nil,
      statusMessage: "Happy Mom, Happy Baby!",
      bio: " Accompany is a pregnant app..."
    )
  }
  
}

struct AccompanyUser: CustomStringConvertible {
  
  var id: String
  var info: Info
  // TODO: add default todos
  var todoLists = [Trimester: TodoList]()
  // TODO: Photos
  var media: [URL] = [URL]()
  var contractions = [Contractions]()
  var note: String = ""
  var isNotificationOn: Bool = false
  
  var dictionary: [String: Any] {
    return [
      "id": id,
      "username": info.username,
      "email": info.email,
      "baby_name": info.babyName,
      "date_of_pregnancy": info.dateOfPregnancy!.formattedDate,
      "due_date": info.dueDate!.formattedDate,
      "status_message": info.statusMessage,
      "bio": info.bio,
      "notes": note,
      "is_notification_on": isNotificationOn,
    ]
  }
  
  var description: String {
    return """
      id: \(id),
      username: \(info.username),
      email: \(info.email),
      babyName: \(info.babyName),
      dateOfPregnancy: \(info.dateOfPregnancy?.formattedDate ?? "NONE"),
      dueDate: \(info.dueDate?.formattedDate ?? "NONE"),
      todoLists: \(todoLists.description)
    """
  }
  
}

extension AccompanyUser {
  
  init?(_ snapshot: DataSnapshot) {
    
    let id = snapshot.childSnapshot(forPath: "id").value as? String ?? "id"
    let username = snapshot.childSnapshot(forPath: "username").value as? String ?? "username"
    let email = snapshot.childSnapshot(forPath: "email").value as? String ?? "email"
    let babyName = snapshot.childSnapshot(forPath: "baby_name").value as? String ?? "baby_name"
    let dateOfPregnancyStr = snapshot.childSnapshot(forPath: "date_of_pregnancy").value as? String ?? "date of pregnancy"
    let dateOfPregnancy = Date.getDateFrom(string: dateOfPregnancyStr)!
    let dueDateStr = snapshot.childSnapshot(forPath: "due_date").value as? String ?? "due date"
    let dueDate = Date.getDateFrom(string: dueDateStr)!
    let statusMessage = snapshot.childSnapshot(forPath: "status_message").value as? String ?? "status_message"
    let bio = snapshot.childSnapshot(forPath: "bio").value as? String ?? "bio"
    let note = snapshot.childSnapshot(forPath: "note").value as? String ?? "note"
    let isNotificationOn = snapshot.childSnapshot(forPath: "is_notification_on").value as? Bool ?? false

    let info = Info(
      username: username,
      email: email,
      babyName: babyName,
      dateOfPregnancy: dateOfPregnancy,
      dueDate: dueDate,
      statusMessage: statusMessage,
      bio: bio
    )
    
    let todoListsSnapshot = snapshot.childSnapshot(forPath: "todo_lists")
    let todoListDict = todoListsSnapshot.value as? [String: Any]
    
    var todoLists = [Trimester: TodoList]()
    var todoList: TodoList?
    var todoListSnapshot: DataSnapshot!
    
    todoListDict?.forEach({ (key, value) in
      switch key {
      case Trimester.firstTrimester.description:
        todoListSnapshot = todoListsSnapshot.childSnapshot(forPath: Trimester.firstTrimester.description)
        todoList = TodoList(todoListSnapshot, of: .firstTrimester)!
        todoLists[Trimester.firstTrimester] = todoList
        
      case Trimester.secondTrimester.description:
        todoListSnapshot = todoListsSnapshot.childSnapshot(forPath: Trimester.secondTrimester.description)
        todoList = TodoList(todoListSnapshot, of: .secondTrimester) ?? TodoList(trimester: .secondTrimester, todos: [Todo]())
        todoLists[Trimester.secondTrimester] = todoList
        
      case Trimester.thirdTrimester.description:
        todoListSnapshot = todoListsSnapshot.childSnapshot(forPath: Trimester.thirdTrimester.description)
        todoList = TodoList(todoListSnapshot, of: .thirdTrimester) ?? TodoList(trimester: .thirdTrimester, todos: [Todo]())
        todoLists[Trimester.thirdTrimester] = todoList
        
      case Trimester.after.description:
        todoListSnapshot = todoListsSnapshot.childSnapshot(forPath: Trimester.after.description)
        todoList = TodoList(todoListSnapshot, of: .after) ?? TodoList(trimester: .after, todos: [Todo]())
        todoLists[Trimester.after] = todoList
        
      default:
        todoList = nil
      }
    })
    
    // TODO: media init
    let media = [URL]()
    
    // TODO: Contractions init
    let contractions = [Contractions]()

    self.init(id: id, info: info, todoLists: todoLists, media: media, contractions: contractions, note: note, isNotificationOn: isNotificationOn)
    
  }
  
}
