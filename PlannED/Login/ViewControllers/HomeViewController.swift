//
//  ViewController.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 6/23/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController{

    let userData = UserData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
        
    @IBAction func onLoginClick(_ sender: Any){
        
        performSegue(withIdentifier: "loginToHomeSegue", sender: sender)
    }
    
    func setUpNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}

