//
//  UserViewController.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 7/24/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//

import SwiftUI
import FirebaseDatabase
import FirebaseAuth
import FirebaseCore
import GoogleMobileAds

class UserViewController: UIViewController {
 
    @IBOutlet weak var nameLabel       : UILabel!
    @IBOutlet weak var addEventLabel   : UILabel!
    @IBOutlet weak var email           : UILabel!
    @IBOutlet weak var tableView       : UITableView!
    @IBOutlet weak var transparentView : UIView!
    
    @IBOutlet weak var englishTextField: UITextField!
    @IBOutlet weak var readingTextField: UITextField!
    @IBOutlet weak var mathTextField   : UITextField!
    @IBOutlet weak var scienceTextField: UITextField!
    @IBOutlet weak var writingTextField: UITextField!
    
    @IBOutlet weak var englishStackView: UIStackView!
    @IBOutlet weak var readingStackView: UIStackView!
    @IBOutlet weak var mathStackView   : UIStackView!
    @IBOutlet weak var scienceStackView: UIStackView!
    @IBOutlet weak var writingStackView: UIStackView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var adContainer: UIView!
    
    let ref = Database.database().reference()
    
    let headerTitles = ["Colleges", "SATs", "ACTs"]
    
    lazy var adBannerView: GADBannerView = {
        let adBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        adBannerView.adUnitID = "ca-app-pub-8501671653071605/1974659335"
        adBannerView.delegate = self
        adBannerView.rootViewController = self
        
        return adBannerView
    }()
    
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = User.getFirstName() + " " + User.getLastName()
        email.text = User.getEmail()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        transparentView.alpha = 0
        transparentView.isHidden = true
        
        englishTextField.delegate = self
        readingTextField.delegate = self
        mathTextField.delegate = self
        scienceTextField.delegate = self
        writingTextField.delegate = self
        
        datePicker.maximumDate = Date()
        
        adBannerView.load(GADRequest())
        
    }
    
    // MARK: doneAddbtnPressed
    @IBAction func doneAddbtnPressed(_ sender: Any) {
        
        if addEventLabel.text == "Add SAT"{
            ifAddSAT()
        }
        else if addEventLabel.text == "Add ACT"{
            ifAddACT()
        }
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: ifAddSAT
    func ifAddSAT() {
        let formatter = NumberFormatter()
        
        var satEnglish = Int()
        var satMath = Int()
        var satWriting = Int()
        
        var i = Int()
        
        if englishTextField.text != "" {
            let n = formatter.number(from: englishTextField.text!) as! Double
            if n > 800.0 || n < 200.0 || n.truncatingRemainder(dividingBy: 10) > 0{
                let alert = UIAlertController(title:"Out of SAT Range", message: "The number you typed is impossible to get on an SAT", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            } else {
                satEnglish = Int(n)
                i += 1
            }
        }
        if mathTextField.text != "" {
            let n = formatter.number(from: mathTextField.text!) as! Double
            if  n > 800.0 || n < 200.0 || n.truncatingRemainder(dividingBy: 10) > 0 {
                let alert = UIAlertController(title:"Out of SAT Range", message: "The number you typed is impossible to get on an SAT", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            } else {
                satMath = Int(n)
                i += 1
            }
        }
            
        if writingTextField.text != "" {
            let n = formatter.number(from: writingTextField.text!) as! Double
            if n > 24 || n < 6 {
                let alert = UIAlertController(title: "Out of SAT Range", message: "The number you typed is impossible to get on an SAT. ", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
                
                i += 1
                
            } else {
                satWriting = Int(n)
            }
        }
        
        
        if englishTextField.text == "" || mathTextField.text == "" {
            let alert = UIAlertController(title:"Invalid Score", message: "Please type in a valid score.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        } else if i == 2 {
            cancelAddbtnPressed(self)
            User.addTakenSAT(english: satEnglish, math: satMath, writing: satWriting, date: datePicker.date)
        } else if i == 3 {
            satWriting = 0
            cancelAddbtnPressed(self)
            User.addTakenSAT(english: satEnglish, math: satMath, writing: satWriting, date: datePicker.date)
        }
    }
    
    // MARK: ifAddACT
    func ifAddACT() {
        let formatter = NumberFormatter()
        
        var actEnglish = Double()
        var actReading = Double()
        var actMath    = Double()
        var actWriting = Double()
        var actScience = Double()
        
        var i = Int()
        
        if englishTextField.text != ""{
            let n = formatter.number(from: englishTextField.text!) as! Double
            if n > 36 || n < 1 {
                let alert = UIAlertController(title:"Out of ACT Range", message: "The number you typed is impossible to get on an ACT", preferredStyle: .alert)
               
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
               
                self.present(alert, animated: true)
            } else {
                actEnglish = n
                i += 1
            }
        }
        if readingTextField.text != ""{
            let n = formatter.number(from: readingTextField.text!) as! Double
            if n > 36 || n < 1 {
                let alert = UIAlertController(title:"Out of ACT Range", message: "The number you typed is impossible to get on an ACT", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                      
                self.present(alert, animated: true)
            } else {
                actReading = n
                i += 1
            }
        }
        if mathTextField.text != "" {
            let n = formatter.number(from: mathTextField.text!) as! Double
            if  n > 36 || n < 1 {
                let alert = UIAlertController(title:"Out of ACT Range", message: "The number you typed is impossible to get on an ACT", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            } else {
                actMath = n
                i += 1
            }
        }
        if scienceTextField.text != ""{
            let n = formatter.number(from: scienceTextField.text!) as! Double
            if n > 36 || n < 1 {
                let alert = UIAlertController(title:"Out of ACT Range", message: "The number you typed is impossible to get on an ACT", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                      
                self.present(alert, animated: true)
            } else {
                actScience = n
                i += 1
            }
        }
        if writingTextField.text != "" {
            let n = formatter.number(from: writingTextField.text!) as! Double
            if n > 36 || n < 1 {
                let alert = UIAlertController(title: "Out of SAT Range", message: "The number you typed is impossible to get on an SAT", preferredStyle: .alert)
                    
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
                
                i += 1
            } else {
                actWriting = n
            }
        }
           
           
        if englishTextField.text == "" || mathTextField.text == "" {
            let alert = UIAlertController(title:"Invalid Score", message: "Please type in a valid score.", preferredStyle: .alert)
           
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
           
            self.present(alert, animated: true)
        } else if i == 4{
            User.addTakenACT(english: actEnglish, reading: actReading, math: actMath, science: actScience, writing: actWriting, date: datePicker.date)
            cancelAddbtnPressed(self)
        } else if i == 5 {
            actWriting = 0
            User.addTakenACT(english: actEnglish, reading: actReading, math: actMath, science: actScience, writing: actWriting, date: datePicker.date)
        }
        
    }
    
    
    // MARK: cancelAddbtnPressed
    @IBAction func cancelAddbtnPressed(_ sender: Any){
        UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            self.transparentView.alpha = 0.0
        }, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
           self.transparentView.isHidden = true
       }
    }
    
}

// MARK: EXTENSION W/ UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate
extension UserViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    // MARK: tableView: numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = 0
        if section == 0 {
            rowCount = User.getChosenColleges().count
        }
        if section == 1 {
            rowCount = User.getTakenSATs().count
        }
        if section == 2 {
            rowCount = User.getTakenACTs().count
        }
        return rowCount
    }
    
    // MARK: tableView: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let frame = tableView.frame
        
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        
        if indexPath.section == 0 {
            cell.textLabel!.text = User.getChosenCollegeNames()[indexPath.row]
            switch(User.getChosenColleges()[indexPath.row].reach) {
            case -1: print("found -1 as reach: \(User.getChosenColleges()[indexPath.row].reach  )")
            case 0: cell.setHorizontalGradientBackground(colorOne: .systemGreen, colorTwo: .black)
            case 1: cell.setHorizontalGradientBackground(colorOne: .systemYellow, colorTwo: .black)
            case 2: cell.setHorizontalGradientBackground(colorOne: .systemRed, colorTwo: .black)
            default:
                print("sumn wnt wreng")
            }
            
        }
        else if indexPath.section == 1 {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-dd-YYYY"
            let string = formatter.string(from: User.getTakenSATs()[indexPath.row].date)
            
            cell.textLabel!.text = "SAT - Date: \(string)  Total: \(User.getTakenSATs()[indexPath.row].total)"
        
        }
        else if indexPath.section == 2 {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-dd-YYYY"
            let string = formatter.string(from: User.getTakenACTs()[indexPath.row].date)
            
            cell.textLabel!.text = "ACT - Date: \(string)  Total: \(User.getTakenACTs()[indexPath.row].total)"
        }
                
        let removeBtn = UIButton(frame: CGRect(x: frame.size.width - 30, y: 12.5, width: 20, height: 20))
        removeBtn.setTitle("-", for: .normal)
        removeBtn.accessibilityLabel = "\(indexPath.section).\(indexPath.row)"
        removeBtn.addTarget(self, action: #selector(removeBtnPressed), for: .touchUpInside)
        
        let topSeperatorLineView = UIView(frame: CGRect(x: 10, y: 0, width: frame.width - 20, height: 0.5))
        topSeperatorLineView.backgroundColor = .white
        
        if indexPath.row != 0 {
            cell.addSubview(topSeperatorLineView)
        }
        
        cell.addSubview(removeBtn)
        
        return cell
    }
    
    // MARK: tableView: numberOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerTitles.count
    }
    
    // MARK: tableView: heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // MARK: tableView: viewForHeaderInSection
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame: CGRect = tableView.frame
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        headerView.backgroundColor = UIColor(red: 75/255, green: 1/255, blue: 100/255, alpha: 1)
        
        let headerTitle = UILabel(frame: CGRect(x: 10, y: 10, width: frame.size.width - 40, height: 20))
        headerTitle.text = headerTitles[section]
        headerTitle.textColor = .white
        
        headerView.addSubview(headerTitle)
        
        let btnAdd = UIButton(frame: CGRect(x: frame.size.width - 30, y: 10, width: 20, height: 20))
        btnAdd.setTitle("+", for: .normal)
        btnAdd.accessibilityIdentifier = "\(section)"
        btnAdd.addTarget(self, action: #selector(addBtnPressed) , for: .touchUpInside)
                
        headerView.addSubview(btnAdd)
        
        return headerView
    }
    
    // MARK: tableView: heightForHeaderInSection
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    // MARK: tableView: didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            Helper.temporaryCollege = User.getChosenColleges()[indexPath.row]
            performSegue(withIdentifier: "toCollege", sender: self)
        }
    }
    
    
    // MARK: removeBtnPressed
    @objc func removeBtnPressed(_ sender: UIButton?) {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        
        var section = Int()
        var row = Int()
        
        print("\(sender?.accessibilityLabel ?? "no")")
        if formatter.number(from: (sender?.accessibilityLabel)!) != nil {
            let digits = sender?.accessibilityLabel?.split(separator: ".")
            
            section = formatter.number(from: String(digits![0])) as! Int
            row = formatter.number(from: String(digits![1])) as! Int
        }
        
        if section == 0 {
            User.removeChosenCollege(collegeIndex: row)
        }
        else if section == 1 {
            User.removeTakenSAT(satIndex: row)
        }
        else if section == 2 {
            User.removeTakenACT(actIndex: row)
        }
        
        tableView.reloadData()
    }
    
    // MARK: addBtnPressed
    @objc func addBtnPressed(_ sender: UIButton?) {
        
        if sender?.accessibilityIdentifier == "0" /*colleges*/ {
            performSegue(withIdentifier: "toCollegeAppPlanning", sender: self)
        }
        else /* sat and act */
        {
            if sender?.accessibilityIdentifier == "1" {
                addEventLabel.text = "Add SAT"
                readingStackView.isHidden = true
                scienceStackView.isHidden = true                
            }
            else if sender?.accessibilityIdentifier == "2"{
                addEventLabel.text = "Add ACT"
                readingStackView.isHidden = false
                scienceStackView.isHidden = false
            }
            UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
                self.transparentView.isHidden = false
                self.transparentView.alpha = 1.0
            }, completion: nil)
        }
    }

    // MARK: textField: shouldChangeCharactersIn
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.isEmpty{
            return true
        }
        
        let currentText = textField.text ?? ""
        let replacementText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        
        return replacementText.isValidDouble(maxDecimalPlaces: 2)
        
    }

}

// MARK: STRING EXTENSION
extension String {
    
    
    // MARK: isValidDouble
    func isValidDouble(maxDecimalPlaces: Int) -> Bool {
        
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        let decimalSeparator = formatter.decimalSeparator ?? "."
        
        if formatter.number(from: self) != nil {
            let split = self.components(separatedBy: decimalSeparator)
            
            let digits = split.count == 2 ? split.last ?? "" : ""
            
            return digits.count <= maxDecimalPlaces
        }
        
        return false
    }
}

// MARK: EXTENSION
extension UserViewController: GADBannerViewDelegate{
    
    /// Tells the delegate an ad request loaded an ad.
    // MARK: adViewDidReceiveAd
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd - User")
        let translateTransform = CGAffineTransform(translationX: 0, y: -bannerView.bounds.size.height)
        bannerView.transform = translateTransform
        
        UIView.animate(withDuration: 0.5) {
            self.adContainer.frame = bannerView.frame
            bannerView.transform = CGAffineTransform.identity
            self.adContainer.addSubview(bannerView)
        }
    }

    /// Tells the delegate an ad request failed.
    // MARK:adView: didFailToReceiveAdWithError
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that a full-screen view will be presented in response to the user clicking on an ad.
    // MARK: adViewWillPresentScreen
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }

    /// Tells the delegate that the full-screen view will be dismissed.
    // MARK: adViewWillDismissScreen
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }

    /// Tells the delegate that the full-screen view has been dismissed.
    // MARK: adViewDidDismissScreen
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }

    /// Tells the delegate that a user click will open another app (such as the App Store), backgrounding the current app.
    // MARK: adViewWillLeaveApplication
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
    
}
