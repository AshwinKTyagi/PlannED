//
//  LoginViewController.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 7/17/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController{

    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onLoginClick(_ sender: Any){
        
        performSegue(withIdentifier: "loginToHomeSegue", sender: sender)
    }
    
}
