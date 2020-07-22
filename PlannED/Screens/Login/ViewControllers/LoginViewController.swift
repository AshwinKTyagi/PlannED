//
//  LoginViewController.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 7/17/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//

import UIKit
import SwiftUI
import FirebaseCore
import FirebaseAuth

class LoginViewController: UIViewController{

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var btnViewPassword: UIButton!
    
    override func viewDidLoad() {
        btnViewPassword.tintColor = UIColor.init(red: 40/255, green: 1/255, blue: 55/255, alpha: 1)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func onLoginClick(_ sender: Any){
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            if error == nil{
                self.performSegue(withIdentifier: "loginToHomeSegue", sender: self)
            }
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
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
}