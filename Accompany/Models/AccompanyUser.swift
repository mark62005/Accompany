//
//  ProfileOption.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-22.
//
import Foundation

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
      dueDate: \(info.dueDate?.formattedDate ?? "NONE")
    """
  }
  
}
