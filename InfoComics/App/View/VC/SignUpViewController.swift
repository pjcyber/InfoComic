//
//  SignUpViewController.swift
//  InfoComics
//
//  Created by Pjcyber on 7/11/20.
//  Copyright © 2020 Pjcyber. All rights reserved.
//

import UIKit
import FirebaseAuth


class SignUpViewController: BaseViewController {
    
    // MARK: - Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    
    // MARK: - UIViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passTextField.delegate = self
        confirmPassTextField.delegate = self
    }
    
    // MARK: - Actions
    @IBAction func onSignUpClick(_ sender: Any) {
        if passTextField.text == confirmPassTextField.text, let email = emailTextField.text, let pass = passTextField.text {
            let auth = FirebaseAuthViewModel(email: email, pass: pass)
            auth.createUser { (result) in
                if result {
                    self.showErrorAlert(title: "SignUp", message: "UserRegister")
                } else {
                    self.showErrorAlert(title: "Error", message: "error trying to register user")
                }
            }
        } else {
            showErrorAlert(title: "Error", message: "insert user and password")
        }
    }
}
