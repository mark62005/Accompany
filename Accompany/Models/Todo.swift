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
}
