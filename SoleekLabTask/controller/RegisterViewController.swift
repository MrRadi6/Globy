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

class RegisterViewController: UIViewController,GIDSignInUIDelegate {
   
    @IBOutlet weak var emailTextField: DesignableTextField!
    @IBOutlet weak var confirmPasswordTextField: DesignableTextField!
    @IBOutlet weak var passwordTextField: DesignableTextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        (UIApplication.shared.delegate as! AppDelegate).goToHomeDelegate = self
        GIDSignIn.sharedInstance().uiDelegate = self

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
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func registerWithFacebook(_ sender: UIButton) {
        
    }
    
    private func makeAlert(title: String,message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let acttion = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(acttion)
        present(alert, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {

        if let error = error {
            makeAlert(title: "Google", message: "Failed to signin with your gmail account")
            print(error)
            return
        }
        else {
            print("login success")
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (results, error) in
            if let error = error {
                self.makeAlert(title: "Google", message: "failed to register with gmail")
                print(error)
                return
            }
            
            // User is signed in
            self.performSegue(withIdentifier: "registerToHome", sender: self)
        }
        
    }
}

extension RegisterViewController: homeDelegate{
    func goToHomeScreen(state: Connection) {
        if state == .AuthenticationFailed {
            makeAlert(title: "Authentication", message: "Application Failed to authenticate")
        }
        else if state == .GmailFailed {
            makeAlert(title: "Gmail", message: "Failed to login with gmail")
        }
        else if state == .Success {
            performSegue(withIdentifier: "registerToHome", sender: self)
        }
    }
}
