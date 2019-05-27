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
import FBSDKCoreKit
import FBSDKLoginKit
import SVProgressHUD

class RegisterViewController: UIViewController,GIDSignInUIDelegate {
   
    @IBOutlet weak var emailTextField: DesignableTextField!
    @IBOutlet weak var confirmPasswordTextField: DesignableTextField!
    @IBOutlet weak var passwordTextField: DesignableTextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        (UIApplication.shared.delegate as! AppDelegate).goToHomeDelegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        emailTextField.delegate = self
        confirmPasswordTextField.delegate = self
        passwordTextField.delegate = self
    }

    @IBAction func registerButtonPressed(_ sender: DesignableButton) {
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let confirmPassword = confirmPasswordTextField.text else { return }
        
        
        if validateEmail(candidate: email) == false {
            makeAlert(title: "invalid Email", message: "please enter a valid email Address")
        }
        else if validatePassword(candidate: password) == false {
            makeAlert(title: "Invalid Password", message: "Please enter Minimum eight characters, at least one uppercase letter, one lowercase letter , one number and one specail character #?!@$%^&*-")
        }
        else if password != confirmPassword {
            makeAlert(title: "Invalid Password", message: "your password does not match")
        }
        else{
            
            SVProgressHUD.show()
            Auth.auth().createUser(withEmail: email, password: password) { (results, error) in
                if error != nil{
                    SVProgressHUD.dismiss()
                    self.makeAlert(title: "Registration Failed", message: "Email already in use try another one")
                }
                else {
                    SVProgressHUD.dismiss()
                    self.performSegue(withIdentifier: "registerToHome", sender: self)
                }
            }
        }
        
    }
    
    @IBAction func registerWithGmail(_ sender: UIButton) {
        SVProgressHUD.show()
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    // MARK: - Facebook login methods
    @IBAction func registerWithFacebook(_ sender: UIButton) {
        let fbLoginManager = LoginManager()
        
        fbLoginManager.logIn(permissions: ["email","public_profile"], from: self) { (results, error) in
            if error != nil {
                SVProgressHUD.dismiss()
                self.makeAlert(title: "Facebook", message: "error login with facebook")
                return
            }
            self.loginTofirebaseWithFB()
        }
    }
    
    func loginTofirebaseWithFB(){
        guard let token = AccessToken.current else { return }
        let credentials = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
        SVProgressHUD.show()
        Auth.auth().signIn(with: credentials) { (results, error) in
            if let error = error {
                SVProgressHUD.dismiss()
                self.makeAlert(title: "Facebook", message: "failed to register with facebook \(error.localizedDescription)")
                print(error)
                return
            }
            
            // User is signed in
            SVProgressHUD.dismiss()
            self.performSegue(withIdentifier: "registerToHome", sender: self)
        }
        
    }
    
    
    //MARK: - Gmail login Delegate methods
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {

        if let error = error {
            SVProgressHUD.dismiss()
            makeAlert(title: "Google", message: "Failed to signin with your gmail account \(error.localizedDescription)")
            print(error)
            return
        }
        
        guard let authentication = user.authentication else {
            SVProgressHUD.dismiss()
            return
        }
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (results, error) in
            if let error = error {
                SVProgressHUD.dismiss()
                self.makeAlert(title: "Google", message: "failed to register with gmail \(error.localizedDescription)")
                print(error)
                return
            }
            
            // User is signed in
            SVProgressHUD.dismiss()
            self.performSegue(withIdentifier: "registerToHome", sender: self)
        }
        
    }
    
    private func makeAlert(title: String,message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let acttion = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(acttion)
        present(alert, animated: true, completion: nil)
    }
    
    private func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    
    private func validatePassword(candidate: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: candidate)
    }
    
}
// MARK: - Textfield delegate methods
extension RegisterViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}


//MARK: go to home Delegate Methods
extension RegisterViewController: homeDelegate{
    func goToHomeScreen(state: Connection) {
        if state == .AuthenticationFailed {
            makeAlert(title: "Authentication", message: "Application Failed to authenticate")
        }
        else if state == .GmailFailed {
            makeAlert(title: "Gmail", message: "Failed to login with gmail")
        }
        else if state == .Success {
            SVProgressHUD.dismiss()
            performSegue(withIdentifier: "registerToHome", sender: self)
        }
    }
}
