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
import FirebaseDatabase

class LoginViewController: UIViewController{

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var btnViewPassword: UIButton!
    
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        btnViewPassword.tintColor = UIColor.init(red: 40/255, green: 1/255, blue: 55/255, alpha: 1)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func onLoginClick(_ sender: Any){
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            if error == nil{
                self.ref.child("users").child(Auth.auth().currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                    // Get user value
                        let value = snapshot.value as? NSDictionary
                        User.setEmail(email: value?["email"] as? String ?? "")
                        User.setFirstName(firstName: value?["firstName"] as? String ?? "")
                        User.setLastName(lastName: value?["lastName"] as? String ?? "")
                        User.setTakenSATs(sats: value?["takenSATs"] as? [Any] ?? [])
                        User.setTakenACTs(acts: value?["takenACTs"] as? [Any] ?? [])
                        User.setChosenColleges(colleges: value?["chosenColleges"] as? [Any] ?? [] )
                    
                  }) { (error) in
                    print(error.localizedDescription)
                }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:  {
                self.performSegue(withIdentifier: "loginToHomeSegue", sender: self)
            })
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
