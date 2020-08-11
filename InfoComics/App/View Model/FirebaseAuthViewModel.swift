//
//  FirebaseAuthViewModel.swift
//  InfoComics
//
//  Created by Pjcyber on 7/11/20.
//  Copyright © 2020 Pjcyber. All rights reserved.
//

import Foundation
import FirebaseAuth
import Combine

class FirebaseAuthViewModel {
    
    var email: String
    var pass: String
    
    init(email: String, pass: String) {
        self.email = email
        self.pass = pass
    }
    
    
    func createUser(completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: pass) {(authResult, error) in
            if let user = authResult?.user {
                print(user)
                completionBlock(true)
            } else {
                completionBlock(false)
                print(error.debugDescription)
            }
        }
    }
    
    func doLogin(completionBlock: @escaping (_ success: Bool, _ error: Error?) -> Void) {
          Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
              if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                  completionBlock(false, error)
              } else {
                  completionBlock(true, nil)
              }
          }
      }
    
}
