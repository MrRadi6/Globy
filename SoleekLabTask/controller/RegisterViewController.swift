//
//  RegisterViewController.swift
//  SoleekLabTask
//
//  Created by Ahmed Samir on 5/24/19.
//  Copyright © 2019 MrRadix. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: DesignableTextField!
    @IBOutlet weak var confirmPasswordTextField: DesignableTextField!
    @IBOutlet weak var passwordTextField: DesignableTextField!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func registerButtonPressed(_ sender: DesignableButton) {
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let confirmPassword = confirmPasswordTextField.text else { return }
        
        if email.contains("@") == false {
            makeAlert(title: "invalid Email", message: "please enter a valid email Address")
        }
        else if password.count < 8 {
            makeAlert(title: "Invalid Password", message: "please enter a valid password it should has at least 8 characters")
        }
        else if password != confirmPassword {
            makeAlert(title: "Invalid Password", message: "your password does not match")
        }
        else{
            Auth.auth().createUser(withEmail: email, password: password) { (results, error) in
                if error != nil{
                    self.makeAlert(title: "Registration Failed", message: "Email already in use try another one")
                }
                else {
                    self.performSegue(withIdentifier: "registerToHome", sender: self)
                }
            }
        }
        
    }
    
    @IBAction func registerWithGmail(_ sender: UIButton) {
        
    }
    
    @IBAction func registerWithFacebook(_ sender: UIButton) {
        
    }
    
    private func makeAlert(title: String,message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let acttion = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(acttion)
        present(alert, animated: true, completion: nil)
    }
}
