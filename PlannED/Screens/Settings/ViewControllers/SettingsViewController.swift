//
//  SettingsViewController.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 7/20/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//
import SwiftUI
import FirebaseCore
import FirebaseAuth

class SettingsViewController: UITableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signOutBtnPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        }
        catch let signOutError as NSError {
            print ("Error signing out:  %@", signOutError)
        }
        
        self.performSegue(withIdentifier: "unwindToStartController", sender: self)
        
        
    }
    
    @IBAction func planningBtnPressed(_ sender: Any){
        self.performSegue(withIdentifier: "toPlanning", sender: self)
    }
}
