//
//  ViewController.swift
//  InfoComics
//
//  Created by Pjcyber on 7/5/20.
//  Copyright © 2020 Pjcyber. All rights reserved.
//

import UIKit

class onBoardingViewController: UIViewController , UITextFieldDelegate {
    
    // MARK: - Properties
    @IBOutlet weak var loginViewBtn: UIButton!
    @IBOutlet weak var signUpViewBtn: UIButton!
    @IBOutlet weak var viewContainer: UIView!
    
    // MARK: - Global Variables
    var position: CGFloat = 0
    var keyboardShown: Bool = false
    
    // MARK: - UIViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        position = view.frame.origin.y
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: - Actions
    @IBAction func showLoginView(_ sender: Any) {
        signUpViewBtn.setBackgroundImage(UIImage(named: "button"), for: .normal)
        loginViewBtn.setBackgroundImage(UIImage(named: "selectedButton"), for: .normal)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller: UIViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as UIViewController
        
        //add as a childviewcontroller
        addChild(controller)
        
        // Add the child's View as a subview
        viewContainer.addSubview(controller.view)
        controller.view.frame = view.bounds
        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // tell the childviewcontroller it's contained in it's parent
        controller.didMove(toParent: self)
        
        
    }
    
    @IBAction func showSignUpView(_ sender: Any) {
        loginViewBtn.setBackgroundImage(UIImage(named: "button"), for: .normal)
        signUpViewBtn.setBackgroundImage(UIImage(named: "selectedButton"), for: .normal)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller: UIViewController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as UIViewController
        
        //add as a childviewcontroller
        addChild(controller)
        
        // Add the child's View as a subview
        viewContainer.addSubview(controller.view)
        controller.view.frame = view.bounds
        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // tell the childviewcontroller it's contained in it's parent
        controller.didMove(toParent: self)
    }
    
    // subscription to keyboard notification to detect if the keyboard is shown
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    // removing subscription to keyboard notification
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // func to move the view according to the keyboard visibility
    @objc func keyboardWillShow(_ notification: Notification) {
        if !keyboardShown {
            let userInfo = notification.userInfo
            let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
            let keyboardSpace = keyboardSize.cgRectValue.height / 2
            view.frame.origin.y -= keyboardSpace
            keyboardShown.toggle()
        }
    }
    
    @objc func  keyboardWillHide (_ notification: Notification) {
        if keyboardShown {
            view.frame.origin.y = position
            keyboardShown.toggle()
        }
    }
    
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        view.frame.origin.y = position
        return false
    }
}
