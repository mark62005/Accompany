//
//  TodoList.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-16.
//

import Foundation

enum Trimester: String {
  
  case firstTrimester = "1st Trimester"
  case secondTrimester = "2nd Trimester"
  case thirdTrimester = "3rd Trimester"
  case after = "After"
  
}

struct TodoList {
  
  var id: String
  var trimester: Trimester
  var todos: [Todo]?
  
}
