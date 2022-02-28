//
//  DatabaseManager.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-21.
//

import Firebase

struct DatabaseManager {
  
  static var shared = DatabaseManager()
  
  var ref = Database.database().reference()
  
  var currentUser: AccompanyUser!
  
  private init() { }
  
  public func isNewUser(id: String) async throws -> Bool {
    do {
      
      let usersSnapshot = try await ref.child("users").getData()
      return !usersSnapshot.hasChild(id)
      
    } catch {
      throw error
    }
  }
  
  public mutating func insertNewUser(with user: AccompanyUser) async throws {
    do {

      let userPath = "users/\(user.id)"
      // insert new user info
      try await ref.child(userPath).setValue(user.dictionary)
      
      currentUser = user
      
      // insert default todolists
      try await insertDefaultTodoLists(to: userPath)
      print("Successfully created new user with \(user.description)")

    } catch let error as NSError {
      throw error
    }
  }
  
  // MARK: TodoList
  
  private mutating func insertDefaultTodoLists(to path: String) async throws {
    
    do {
      
      var todoLists = [Trimester: TodoList]()
      for i in 0..<Trimester.allCases.count {
        let trimester = Trimester.allCases[i]
        todoLists[trimester] = TodoList(trimester: trimester)
        
        let todos = TodoList.getDefaultTodos(of: trimester)
        for var todo in todos {
          let todoListPath = "\(path)/todo_lists/\(trimester.description)"
          
          let todoId = ref.child(todoListPath).childByAutoId().key!
          todo.id = todoId
          
          try await ref.child("\(todoListPath)/\(todoId)").setValue(todo.dictionary)
          
          todoLists[trimester]!.add(todo)
          
        }
      }
      
      currentUser.todoLists = todoLists
      currentUser.todoLists.forEach { (key, value) in
        print("Key: \(key), value: \(value)")
      }
      
    } catch let error as NSError {
      throw error
    }
    
  }
  
  public mutating func insertNewTodoList(to path: String, with todoList: TodoList, on index: Int) async throws {
    do {
      
      for todo in todoList.todos {
        try await insertNewTodo(to: path, with: todo)
      }
      
    } catch let error as NSError {
      throw error
    }
  }
  
  private mutating func insertNewTodo(to path: String, with todo: Todo) async throws {
    do {
      
      let newTodoRef = try await ref.child(path).childByAutoId().setValue(todo.dictionary)
      try await newTodoRef.getData()
      
    } catch let error as NSError {
      throw error
    }
  }
  
}
