//
//  ViewController.swift
//  SoleekLabTask
//
//  Created by Ahmed Samir on 5/24/19.
//  Copyright © 2019 MrRadix. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var emailTextField: DesignableTextField!
    @IBOutlet weak var passwordTextField: DesignableTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    //MARK: - TextField Delegate Methods
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - Login button Trigered
    @IBAction func loginButtonPressed(_ sender: DesignableButton) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        let alert = UIAlertController(title: "Sign-in Failed", message: "Wrong email or password", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        if email != "" && password != ""{
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    // pop up error alert to user
                    self.present(alert, animated: true, completion: nil)
                }
                else {
                    self.performSegue(withIdentifier: "loginToHome", sender: self)
                }
            }
        }
        else {
            present(alert, animated: true, completion: nil)
        }
    }
    
}

