//
//  BaseViewController.swift
//  InfoComics
//
//  Created by Pjcyber on 7/12/20.
//  Copyright © 2020 Pjcyber. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
