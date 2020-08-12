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
    
    @IBOutlet weak var satTextView: UIView!
    @IBOutlet weak var satView: UIView!
    @IBOutlet weak var satTotal25: UILabel!
    @IBOutlet weak var satTotal25StackView: UIStackView!
    @IBOutlet weak var satTotal75: UILabel!
    @IBOutlet weak var satTotal75StackView: UIStackView!
    @IBOutlet weak var satTotalMid: UILabel!
    @IBOutlet weak var satTotalMidStackView: UIStackView!
    
    @IBOutlet weak var actTextView: UIView!
    @IBOutlet weak var actView: UIView!
    @IBOutlet weak var actTotal25: UILabel!
    @IBOutlet weak var actTotal25StackView: UIStackView!
    @IBOutlet weak var actTotal75: UILabel!
    @IBOutlet weak var actTotal75StackView: UIStackView!
    @IBOutlet weak var actTotalMid: UILabel!
    @IBOutlet weak var actTotalMidStackView: UIStackView!
    
    @IBOutlet weak var demo1TextView: UIView!
    @IBOutlet weak var demo1View: UIView!
    @IBOutlet weak var pctWhite: UILabel!
    @IBOutlet weak var pctWhiteStackView: UIStackView!
    @IBOutlet weak var pctBlack: UILabel!
    @IBOutlet weak var pctBlackStackView: UIStackView!
    @IBOutlet weak var pctAsian: UILabel!
    @IBOutlet weak var pctAsianStackView: UIStackView!
    @IBOutlet weak var pctHispanic: UILabel!
    @IBOutlet weak var pctHispanicStackView: UIStackView!
    
    @IBOutlet weak var demo2View: UIView!
    @IBOutlet weak var pctMarried: UILabel!
    @IBOutlet weak var pctMarriedStackView: UIStackView!
    @IBOutlet weak var pctFemale: UILabel!
    @IBOutlet weak var pctFemaleStackView: UIStackView!
    @IBOutlet weak var pctMale: UILabel!
    @IBOutlet weak var pctMaleStackView: UIStackView!
    @IBOutlet weak var pctBornUS: UILabel!
    @IBOutlet weak var pctBornUSStackView: UIStackView!
    
    @IBOutlet weak var degTextView: UIView!
    @IBOutlet weak var degView: UIView!
    @IBOutlet weak var pctBA: UILabel!
    @IBOutlet weak var pctBAStackView: UIStackView!
    @IBOutlet weak var pctProDeg: UILabel!
    @IBOutlet weak var pctProDegStackView: UIStackView!
    
    let ref = Database.database().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instName.adjustsFontSizeToFitWidth = true
        instName.minimumScaleFactor = 0.2
        
        ref.child("colleges").child(Helper.tempCollegeID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let formatter = NumberFormatter()
            let value = snapshot.value as? NSDictionary
            
            
            self.instName.text = value?["INSTNM"] as? String ?? ""
            
            var string = String()
            var x = Int()
            var y = Int()
            var i = Int()
            
            string = value?["SATVR25"] as? String ?? ""
            if string != "NULL"{
                x = formatter.number(from: string) as! Int
                
                string = value?["SATMT25"] as? String ?? ""
                if string != "NULL"{
                    y = formatter.number(from: string) as! Int
                    
                    let total = x + y
                    self.satTotal25.text = formatter.string(from: NSNumber(value: total))
                }
                else {
                    self.satTotal25StackView.isHidden = true
                    i += 1
                }
            }
            else {
                self.satTotal25StackView.isHidden = true
                i += 1
            }
            
            string = value?["SATVR75"] as? String ?? ""
            if string != "NULL"{
                x = formatter.number(from: string) as! Int
                
                string = value?["SATMT75"] as? String ?? ""
                if string != "NULL"{
                    y = formatter.number(from: string) as! Int
                    
                    let total = x + y
                    self.satTotal75.text = formatter.string(from: NSNumber(value: total))
                }
                else {
                    self.satTotal75StackView.isHidden = true
                    i += 1
                }
            }
            else {
                self.satTotal75StackView.isHidden = true
                i += 1
            }
            
            
            string = value?["SATVRMID"] as? String ?? ""
            if string != "NULL"{
                x = formatter.number(from: string) as! Int
                
                string = value?["SATMTMID"] as? String ?? ""
                if string != "NULL"{
                    y = formatter.number(from: string) as! Int
                    
                    let total = x + y
                    self.satTotalMid.text = formatter.string(from: NSNumber(value: total))
                }
                else {
                    self.satTotalMidStackView.isHidden = true
                    i += 1
                }
            }
            else {
                self.satTotalMidStackView.isHidden = true
                i += 1
            }
            
            if i == 3 {
                self.satTextView.heightAnchor.constraint(equalToConstant: 0).isActive = true
                self.satTextView.isHidden = true
              
                self.satView.heightAnchor.constraint(equalToConstant: 0).isActive = true
                self.satView.isHidden = true
            }
            
            i = 0
            
            string = value?["ACTCM25"] as? String ?? ""
            if string != "NULL"{
                self.actTotal25.text = string
            }
            else {
                self.actTotal25StackView.isHidden = true
                i += 1
            }
            
            string = value?["ACTCM75"] as? String ?? ""
            if string != "NULL"{
                self.actTotal75.text = string
            }
            else {
                self.actTotal75StackView.isHidden = true
                i += 1
            }
            
            string = value?["ACTCMMID"] as? String ?? ""
            if string != "NULL"{
                self.actTotalMid.text = string
            }
            else {
                self.actTotalMidStackView.isHidden = true
                i += 1
            }
            
            if i == 3 {
                self.actTextView.heightAnchor.constraint(equalToConstant: 0).isActive = true
                self.actTextView.isHidden = true
              
                self.actView.heightAnchor.constraint(equalToConstant: 0).isActive = true
                self.actView.isHidden = true
            }
            i = 0
            
            var v = Double()
            string = value?["PCT_WHITE"] as? String ?? ""
            if string != "NULL" && string != "PrivacySuppressed" {
                v = formatter.number(from: string) as! Double
                self.pctWhite.text = String(format: "%.2f", v) + "%"
            }
            else {
                self.pctWhiteStackView.isHidden = true
                i += 1
            }
            
            string = value?["PCT_BLACK"] as? String ?? ""
            if string != "NULL" && string != "PrivacySuppressed" {
                v = formatter.number(from: string) as! Double
                self.pctBlack.text = String(format: "%.2f", v) + "%"
            }
            else {
                self.pctBlackStackView.isHidden = true
                i += 1
            }
            
            string = value?["PCT_ASIAN"] as? String ?? ""
            if string != "NULL" && string != "PrivacySuppressed" {
                v = formatter.number(from: string) as! Double
                self.pctAsian.text = String(format: "%.2f", v) + "%"
            }
            else {
                self.pctAsianStackView.isHidden = true
                i += 1
            }
            
            string = value?["PCT_HISPANIC"] as? String ?? ""
            if string != "NULL" && string != "PrivacySuppressed" {
                v = formatter.number(from: string) as! Double
                self.pctHispanic.text = String(format: "%.2f", v) + "%"
            }
            else {
                self.pctHispanicStackView.isHidden = true
                i += 1
            }
            
            if i == 4 {
                let frame = self.demo1View.frame
                
                self.demo2View.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
                self.demo2View.leadingAnchor.constraint(equalToSystemSpacingAfter: self.demo1View.leadingAnchor, multiplier: 1).isActive = true
                self.demo1View.widthAnchor.constraint(equalToConstant: 0).isActive = true
                self.demo1View.isHidden = true
                
                
            }
            
            string = value?["MARRIED"] as? String ?? ""
            if string != "NULL" && string != "PrivacySuppressed"{
                v = formatter.number(from: string) as! Double
                self.pctMarried.text = String(format: "%.2f",100 * v) + "%"
            }
            else {
                self.pctMarriedStackView.isHidden = true
                i += 1
            }
            
            string = value?["FEMALE"] as? String ?? ""
            if string != "NULL" && string != "PrivacySuppressed" {
                v = formatter.number(from: value?["FEMALE"] as? String ?? "0.0") as! Double
                self.pctFemale.text = String(format: "%.2f", 100 * v) + "%"
                v = 1 - v
                self.pctMale.text = String(format: "%.2f", 100 * v) + "%"
                
            }
            else {
                self.pctFemaleStackView.isHidden = true
                self.pctMaleStackView.isHidden = true
                i += 2
            }
            
            string = value?["PCT_BORN_US"] as? String ?? ""
            if string != "NULL" && string != "PrivacySuppressed" {
                v = formatter.number(from: string) as! Double
                self.pctBornUS.text = String(format: "%.2f", v) + "%"
            }
            else {
                self.pctBornUSStackView.isHidden = true
                i += 1
            }
            
            if i == 8 {
                self.demo1View.heightAnchor.constraint(equalToConstant: 0).isActive = true
                self.demo1View.isHidden = true
                
                self.demo2View.heightAnchor.constraint(equalToConstant: 0).isActive = true
                self.demo2View.isHidden = true
                
                self.demo1TextView.heightAnchor.constraint(equalToConstant: 0).isActive = true
                self.demo1TextView.isHidden = true
            }
            else if self.demo1View.isHidden {
                i += -4
                i = 4 - i
                self.demo2View.heightAnchor.constraint(equalToConstant: 20 + (CGFloat(i) * self.pctBornUSStackView.frame.height)).isActive = true
            }
            else {
                i = 4 - i
                
                self.demo2View.heightAnchor.constraint(equalToConstant: 20 + (CGFloat(i) * self.pctBornUSStackView.frame.height)).isActive = true
            }
            i = 0
            
            string = value?["PCT_BA"] as? String ?? ""
            if string != "NULL" && string != "PrivacySuppressed" {
                v = formatter.number(from: string) as! Double
                self.pctBA.text = String(format: "%.2f", v) + "%"
            }
            else {
                self.pctBAStackView.isHidden = true
                i += 1
            }
            
            string = value?["PCT_GRAD_PROF"] as? String ?? ""
            if string != "NULL" && string != "PrivacySuppressed" {
                v = formatter.number(from: string) as! Double
                self.pctProDeg.text = String(format: "%.2f", v) + "%"
            }
            else {
                self.pctProDegStackView.isHidden = true
                i += 1
            }
            
            if i == 2 {
                self.degView.heightAnchor.constraint(equalToConstant: 0).isActive = true
                self.degView.isHidden = true
                
                
                self.degTextView.heightAnchor.constraint(equalToConstant: 0).isActive = true
                self.degTextView.isHidden = true
            }
        })
    }
}



