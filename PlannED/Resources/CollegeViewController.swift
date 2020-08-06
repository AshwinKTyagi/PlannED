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
    
    @IBOutlet weak var instName: UILabel!
    
    @IBOutlet weak var satTotal25: UILabel!
    @IBOutlet weak var satTotal75: UILabel!
    @IBOutlet weak var satTotalMid: UILabel!
    
    @IBOutlet weak var actTotal25: UILabel!
    @IBOutlet weak var actTotal75: UILabel!
    @IBOutlet weak var actTotalMid: UILabel!
    
    let ref = Database.database().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.child("colleges").child(Helper.tempCollegeID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let formatter = NumberFormatter()
            let value = snapshot.value as? NSDictionary
            
            
            self.instName.text = value?["INSTNM"] as? String ?? ""
            
            var x = formatter.number(from: value?["SATVR25"] as? String ?? "") as! Int
            var y = formatter.number(from: value?["SATMT25"] as? String ?? "") as! Int
            var total = x + y
            self.satTotal25.text = formatter.string(from: NSNumber(value: total))
            
            x = formatter.number(from: value?["SATVR75"] as? String ?? "") as! Int
            y = formatter.number(from: value?["SATMT75"] as? String ?? "") as! Int
            total = x + y
            self.satTotal75.text = formatter.string(from: NSNumber(value: total))
            
            x = formatter.number(from: value?["SATVRMID"] as? String ?? "") as! Int
            y = formatter.number(from: value?["SATMTMID"] as? String ?? "") as! Int
            total = x + y
            self.satTotalMid.text = formatter.string(from: NSNumber(value: total))
            
            self.actTotal25.text = value?["ACTCM25"] as? String ?? ""
            self.actTotal75.text = value?["ACTCM75"] as? String ?? ""
            self.actTotalMid.text = value?["ACTCMMID"] as? String ?? ""
            
        })
    }
    
    
    
}


