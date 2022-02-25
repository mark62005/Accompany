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
  var babyName: String?
  var dateOfPregnancy: Date?
  var dueDate: Date?
  var statusMessage: String?
  var bio: String?
  
  static func loadSampleInfo() -> Info {
    return Info(username: "Username:", email: "Email:", babyName: "Baby's Name: (optional)", statusMessage: "Status Message: (optional)", bio: "Bio: (optional)")
  }
  
}

struct User {
  
  var info: Info?
  // TODO: add default todos
  var todolists = [TodoList]()
  // TODO: Photos
  var media: [URL]?
  var contractions: [Contractions]
  var note: String?
  var isNotificationOn: Bool = false
  
}
