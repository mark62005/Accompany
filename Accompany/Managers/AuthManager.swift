//
//  AuthManager.swift
//  InstagramDemo
//
//  Created by Mark Wong on 2022-02-20.
//

import FirebaseAuth
import StoreKit

public class AuthManager {
  
  enum AuthError: Error, LocalizedError {
    case createUserError
    
    public var errorDescription: String? {
      switch self {
      case .createUserError:
        return "Could not create user"
      }
    }
  }
  
  static let shared = AuthManager()
  
  private let auth = Auth.auth()
  
  private init() { }
  
  public func registerNewUser(email: String, firstName: String, lastName: String, password: String) async throws {
    
    // 1. check if email is available
//    guard DatabaseManager.shared.isEmailAvailable(with: email) else {
//      return
//    }
  
    // TODO: 2. check if password is validate
      
    do {
      // 3. create account
      let result = try await auth.createUser(withEmail: email, password: password)
      let uid = result.user.uid
      
      let user = AccompanyUser(id: uid,
                      info:
                        Info(
                          username: "\(firstName) \(lastName)",
                          email: email, babyName: "Not decided yet",
                          dateOfPregnancy: nil,
                          dueDate: nil
                        ),
                      todolists: [TodoList]()
                 )
      
      // 4. insert account into database
      try await DatabaseManager.shared.insertNewUser(with: user)
    } catch {
      throw error
    }
    
  }
  
  public func logInUser(email: String, password: String) async throws {
    
    do {
      let result = try await auth.signIn(withEmail: email, password: password)
      print("Result: \(result.user)")
    } catch {
      throw error
    }
    
  }
  
  public func logOutUser() throws {
    do {
      try Auth.auth().signOut()
    } catch {
      throw error
    }
  }
  
}
