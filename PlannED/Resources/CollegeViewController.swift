//
//  CollegeViewController.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 8/4/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase

class CollegeViewController: UIViewController{
    
//    @IBOutlet weak var instName: UILabel!
//    
//    @IBOutlet weak var act25: UILabel!
//    @IBOutlet weak var act50: UILabel!
//    @IBOutlet weak var act75: UILabel!
//    @IBOutlet weak var sat25: UILabel!
//    @IBOutlet weak var sat50: UILabel!
//    @IBOutlet weak var sat75: UILabel!
    
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.child("colleges").child(Helper.tempCollegeID).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            print("\(value)")
            
        })
    }
    
    
    
}


