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
    @IBOutlet weak var favoritesBtn: UIButton!
    
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
    @IBOutlet weak var pctInternational: UILabel!
    @IBOutlet weak var pctInternationalStackView: UIStackView!
    
    @IBOutlet weak var degTextView: UIView!
    @IBOutlet weak var degView: UIView!
    @IBOutlet weak var pctBA: UILabel!
    @IBOutlet weak var pctBAStackView: UIStackView!
    @IBOutlet weak var pctProDeg: UILabel!
    @IBOutlet weak var pctProDegStackView: UIStackView!
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoBtn: UIButton!
    
    var reach: Int = -1
    
    let ref = Database.database().reference()
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesBtn.setImage(UIImage(systemName: "star"), for: .normal)
        favoritesBtn.setImage(UIImage(systemName: "star.fill"), for: .selected)
        
        infoBtn.setImage(UIImage(systemName: "info.circle"), for: .normal)
        infoBtn.setImage(UIImage(systemName: "info.circle.fill"), for: .selected)
        
        favoritesBtn.isHidden = false
        
        instName.adjustsFontSizeToFitWidth = true
        instName.minimumScaleFactor = 0.2
        
        if User.getChosenCollegeIPSEDs().contains(Helper.temporaryCollege.ipsed){
            favoritesBtn.isSelected = true
        }
        
        ref.child("colleges").child(Helper.temporaryCollege.ipsed).observeSingleEvent(of: .value, with: { (snapshot) in
            
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
                    
                    if i == 0 {
                        
                    }
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
                self.pctInternational.text = String(format: "%.2f", 100 - v) + "%"
            }
            else {
                self.pctInternationalStackView.isHidden = true
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
                self.demo2View.heightAnchor.constraint(equalToConstant: 20 + (CGFloat(i) * self.pctInternationalStackView.frame.height)).isActive = true
            }
            else {
                i = 4 - i
                
                self.demo2View.heightAnchor.constraint(equalToConstant: 20 + (CGFloat(i) * self.pctInternationalStackView.frame.height)).isActive = true
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
            
            switch(self.calcReach()) {
            case 0: self.view.setVerticalGradientBackground(colorOne: .systemGreen, colorTwo: .black)
                self.reach = 0
            case 1: self.view.setVerticalGradientBackground(colorOne: .systemYellow, colorTwo: .black)
                self.reach = 1
            case 2: self.view.setVerticalGradientBackground(colorOne: .systemRed, colorTwo: .black)
                self.reach = 2
            default:
                print("sumn wnt wreng")
            }
            
        })
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    
    // MARK: favoritesBtnPressed
    @IBAction func favoritesBtnPressed(_ sender: UIButton) {
        if sender.isSelected {
            User.removeChosenCollege(college: Helper.temporaryCollege)
            sender.isSelected = false
        }
        else {
            Helper.temporaryCollege.reach = reach
            User.addChosenCollege(college: Helper.temporaryCollege)
            sender.isSelected = true
        }
        
    }
    
    // MARK: inforBtnPressed
    @IBAction func infoBtnPressed(_ sender: UIButton) {
        if sender.isSelected {
            infoView.isHidden = true
            sender.isSelected = false
        }
        else {
            infoView.isHidden = false
            sender.isSelected = true
        }
    }
    
    func calcReach() -> Int {
        let formatter = NumberFormatter()
        var high = Int()
        
        var temp = Helper.calcReachSAT(sat25: formatter.number(from: satTotal25.text ?? "-1") as! Int, sat75: formatter.number(from: satTotal75.text ?? "-1") as! Int)
        if temp == 2{
            return 2
        }
        high = temp
        
        temp = Helper.calcReachACT(act25: formatter.number(from: actTotal25.text ?? "-1") as! Int, act75: formatter.number(from: actTotal75.text ?? "-1") as! Int)
        if temp == 2 {
            return 2
        }
        else if high == 1 || temp == 1{
            return 1
        }
        
        temp = Helper.calcReachACT(actmid: formatter.number(from: actTotalMid.text ?? "-1") as! Int)
        if temp == 2 {
            return 2
        }
        else if temp > high{
            high = temp
        }
        
        temp = Helper.calcReachSAT(satmid: formatter.number(from: satTotalMid.text ?? "-1") as! Int)
        if temp == 2{
            return 2
        }
        else if temp > high{
                high = temp
        }
        
        return high
    }
}

extension UIView{
    func setVerticalGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setHorizontalGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
