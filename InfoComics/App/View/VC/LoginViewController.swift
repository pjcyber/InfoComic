//
//  LoginViewController.swift
//  InfoComics
//
//  Created by Pjcyber on 7/11/20.
//  Copyright © 2020 Pjcyber. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - UIViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // MARK: - Actions
    @IBAction func onLoginClick(_ sender: Any) {
        guard let email = emailTextField.text, let pass = passwordTextField.text else {
            showErrorAlert(title: "Error", message:  "Please enter valid credentials")
            return
        }
        let auth = FirebaseAuthViewModel(email: email, pass: pass)
        auth.doLogin(completionBlock: { (result, error) in
            if result {
                self.performSegue(withIdentifier: "goToHome", sender: nil)
            } else {
                self.showErrorAlert(title: "Error", message:  "Invalid Credentials")
            }
        })
    }
}
