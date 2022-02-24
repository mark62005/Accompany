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
  var statusMessage: String?
  var bio: String?
  
  static func loadSampleInfo() -> Info {
    return Info(username: "mark62005", email: "mark@email.com", babyName: "Thomas", statusMessage: "LOL", bio: "This is my bio...")
  }
  
}
