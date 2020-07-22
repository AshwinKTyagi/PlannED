//
//  SignUpViewController.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 7/17/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//
import UIKit
import SwiftUI
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase

class SignUpViewController: UIViewController{

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!
    @IBOutlet weak var btnViewPassword: UIButton!
    @IBOutlet weak var btnViewConfirmPassword: UIButton!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnViewPassword.tintColor = UIColor.init(red: 40/255, green: 1/255, blue: 55/255, alpha: 1)
        btnViewConfirmPassword.tintColor = UIColor.init(red: 40/255, green: 1/255, blue: 55/255, alpha: 1)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
                
        ref = Database.database().reference()

    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        
        if firstName.text == ""{
            let alertController = UIAlertController(title: "Invalid First Name", message: "Please Insert a First Name", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction( title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        else if lastName.text == ""{
            let alertController = UIAlertController(title: "Invalid Last Name", message: "Please Insert a Last Name", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction( title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        else if password.text != passwordConfirm.text {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction( title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        else{
            Auth.auth().createUser(withEmail: email.text!, password: password.text!){ (user, error) in
                if error == nil {
                    self.performSegue(withIdentifier: "signupToHomeSegue", sender: self)
                }
                else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                               
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
            }
                
            }
        }
    }

    @IBAction func viewPasswordButtonPressed(_ sender: Any) {
        if password.isSecureTextEntry{
            password.isSecureTextEntry = false
            btnViewPassword.tintColor = UIColor.lightGray
        }
        else {
            password.isSecureTextEntry = true
            btnViewPassword.tintColor = UIColor.init(red: 40/255, green: 1/255, blue: 55/255, alpha: 1)
        }
    }
    
    @IBAction func viewPasswordButtonConfirmPressed(_ sender: Any) {
        if passwordConfirm.isSecureTextEntry{
            passwordConfirm.isSecureTextEntry = false
            btnViewConfirmPassword.tintColor = UIColor.lightGray
        }
        else {
            passwordConfirm.isSecureTextEntry = true
            btnViewConfirmPassword.tintColor = UIColor.init(red: 40/255, green: 1/255, blue: 55/255, alpha: 1)        }
    }
}

