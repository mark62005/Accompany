//
//  SceneDelegate.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-04.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseAuthUI
import FirebaseEmailAuthUI
import FirebaseOAuthUI
import GoogleSignIn
import FirebaseGoogleAuthUI
import FirebaseFacebookAuthUI
import FirebaseDatabase


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    window = UIWindow(windowScene: windowScene)
    window?.makeKeyAndVisible()
    
    try? Auth.auth().signOut()
    
    if let user = Auth.auth().currentUser {
      // fetch user data?
      
      window?.rootViewController = TabBarViewController()
    } else {
      handleNotAuthenticated()
    }
        
  }
  
  private func handleNotAuthenticated() {
    let authUI = FUIAuth.defaultAuthUI()
    authUI?.shouldHideCancelButton = true
    authUI?.delegate = self
    
    let providers: [FUIAuthProvider] = [
      FUIEmailAuth(),
      FUIGoogleAuth.init(authUI: authUI!),
      FUIFacebookAuth.init(authUI: authUI!),
      FUIOAuth.appleAuthProvider()
    ]
    authUI?.providers = providers
    
    let authVC = authUI!.authViewController()
    authVC.view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    
    self.window?.rootViewController = authVC
  }

  func sceneDidDisconnect(_ scene: UIScene) {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
  }

  func sceneDidBecomeActive(_ scene: UIScene) {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
  }

  func sceneWillResignActive(_ scene: UIScene) {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
  }

  func sceneWillEnterForeground(_ scene: UIScene) {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
  }

  func sceneDidEnterBackground(_ scene: UIScene) {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
  }


}

extension SceneDelegate: FUIAuthDelegate {
  
  func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
    if let user = authDataResult?.user {
    
      Task {
        do {
          
          self.window?.rootViewController = TabBarViewController()
          if try await DatabaseManager.shared.isNewUser(id: user.uid) {
            try await createNewUser(with: user)
          }
          
        } catch let error as NSError {
          print("Error: \(error.localizedDescription)")
        }
      }
      
    } else if let error = error {
      print("Error: \(error.localizedDescription)")
    }
  }
  
  private func signIn(with user: FirebaseAuth.User) async throws {
    // sign in
    print("Successfully signed in with id: \(user.uid), email: \(user.email ?? "")")
  }
  
  private func createNewUser(with user: FirebaseAuth.User) async throws {
    // set baby name, date of pregnancy, due date
    let newUserLandingVC = NewUserLandingViewController()
    newUserLandingVC.titleLabel.text = "Welcome to Accompany, \(user.displayName ?? "")!"
    newUserLandingVC.user = user
    
    newUserLandingVC.modalPresentationStyle = .fullScreen
    self.window?.rootViewController?.present(newUserLandingVC, animated: true)
  }
  
}
