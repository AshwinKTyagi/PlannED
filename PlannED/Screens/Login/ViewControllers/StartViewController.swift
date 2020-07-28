//
//  StartViewController.swift
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

class StartViewController: UIViewController{
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {

    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser != nil {
            let userID = Auth.auth().currentUser?.uid
            ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                User.setEmail(email: value?["email"] as? String ?? "")
                User.setFirstName(firstName: value?["firstName"] as? String ?? "")
                User.setLastName(lastName: value?["lastName"] as? String ?? "")
                User.setTakenSATs(sats: value?["takenSATs"] as? [Any] ?? [])
                User.setTakenACTs(acts: value?["takenACTs"] as? [Any] ?? [])
                User.setChosenColleges(collegeIPEDSIDs: value?["chosenColleges"] as? [String] ?? [] )
              }) { (error) in
                print(error.localizedDescription)
            }
            
            self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
        }
    }
    
    @IBAction func onLoginClick(_ sender: Any){
        
        performSegue(withIdentifier: "startToLoginSegue", sender: sender)
    }
    
    @IBAction func onSignupClick(_ sender: Any){
        
        performSegue(withIdentifier: "startToSignupSegue", sender: sender)
    }
    
}


