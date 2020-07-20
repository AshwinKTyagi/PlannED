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


class StartViewController: UIViewController{
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {

    }
    
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser != nil {
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


