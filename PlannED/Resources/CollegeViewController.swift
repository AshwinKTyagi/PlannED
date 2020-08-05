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
    
    @IBOutlet weak var satvr25: UILabel!
    @IBOutlet weak var satvr75: UILabel!
    @IBOutlet weak var satmt25: UILabel!
    @IBOutlet weak var satmt75: UILabel!
    @IBOutlet weak var satwr25: UILabel!
    @IBOutlet weak var satwr75: UILabel!
    @IBOutlet weak var satvrmid: UILabel!
    @IBOutlet weak var satmtmid: UILabel!
    @IBOutlet weak var satwrmid: UILabel!
    
    @IBOutlet weak var actcm25: UILabel!
    @IBOutlet weak var actcm75: UILabel!
    @IBOutlet weak var acten25: UILabel!
    @IBOutlet weak var acten75: UILabel!
    @IBOutlet weak var actmt25: UILabel!
    @IBOutlet weak var actmt75: UILabel!
    @IBOutlet weak var actwr25: UILabel!
    @IBOutlet weak var actwr75: UILabel!
    @IBOutlet weak var actcmmid: UILabel!
    @IBOutlet weak var actenmid: UILabel!
    @IBOutlet weak var actmtmid: UILabel!
    @IBOutlet weak var actwrmid: UILabel!
    
    let ref = Database.database().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.child("colleges").child(Helper.tempCollegeID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            self.instName.text = value?["INSTNM"] as? String ?? ""
            
            self.satvr25.text = value?["SATVR25"] as? String ?? ""
            self.satvr75.text = value?["SATVR75"] as? String ?? ""
            self.satmt25.text = value?["SATMT25"] as? String ?? ""
            self.satmt75.text = value?["SATMT75"] as? String ?? ""
            self.satwr25.text = value?["SATWR25"] as? String ?? ""
            self.satwr75.text = value?["SATWR75"] as? String ?? ""
            self.satvrmid.text = value?["SATVRMID"] as? String ?? ""
            self.satmtmid.text = value?["SATMTMID"] as? String ?? ""
            self.satwrmid.text = value?["SATWRMID"] as? String ?? ""
            
            self.actcm25.text = value?["ACTCM25"] as? String ?? ""
            self.actcm75.text = value?["ACTCM75"] as? String ?? ""
            self.acten25.text = value?["ACTEN25"] as? String ?? ""
            self.acten75.text = value?["ACTEN75"] as? String ?? ""
            self.actmt25.text = value?["ACTMT25"] as? String ?? ""
            self.actmt75.text = value?["ACTMT75"] as? String ?? ""
            self.actwr25.text = value?["ACTWR25"] as? String ?? ""
            self.actwr75.text = value?["ACTWR75"] as? String ?? ""
            self.actcmmid.text = value?["ACTCMMID"] as? String ?? ""
            self.actenmid.text = value?["ACTENMID"] as? String ?? ""
            self.actmtmid.text = value?["ACTMTMID"] as? String ?? ""
            self.actwrmid.text = value?["ACTWRMID"] as? String ?? ""
            
            
            
            
        })
    }
    
    
    
}


