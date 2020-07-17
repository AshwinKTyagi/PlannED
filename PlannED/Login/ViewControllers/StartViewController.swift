//
//  StartViewController.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 7/17/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//

import UIKit

class StartViewController: UIViewController{
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnLogin = UIButton.attributedButton(button: btnLogin)
        btnSignUp = UIButton.attributedButton(button: btnSignUp)
    }
    
    @IBAction func onLoginClick(_ sender: Any){
        
        performSegue(withIdentifier: "startToLoginSegue", sender: sender)
    }
    
    @IBAction func onSignupClick(_ sender: Any){
        
        performSegue(withIdentifier: "startToSignupSegue", sender: sender)
    }
    
}

extension UIButton {
    class func attributedButton(button: UIButton) -> UIButton {
        
        button.clipsToBounds = true
        button.layer.cornerRadius =  20
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2.0
        return button
    }
}
