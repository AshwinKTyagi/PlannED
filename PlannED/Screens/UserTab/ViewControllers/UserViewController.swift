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

class UserViewController: UIViewController {
 
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addEventLabel: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var transparentView: UIView!
    
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
    
    
    
    let ref = Database.database().reference()
    
    let headerTitles = ["Colleges", "SATs", "ACTs"]
    
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
        
        
    }
    
    @IBAction func doneAddbtnPressed(_ sender: Any) {
        
        if addEventLabel.text == "Add SAT"{
            ifAddSAT()
        }
        else if addEventLabel.text == "Add ACT"{
            ifAddACT()
        }
        
        tableView.reloadData()
    }
    
    func ifAddSAT() {
        let formatter = NumberFormatter()
        
        var satEnglish = Int()
        var satMath = Int()
        var satWriting = Int()
        
        if englishTextField.text != nil{
            let n = formatter.number(from: englishTextField.text!) as! Double
            if n > 800.0 && n < 200.0 && n.truncatingRemainder(dividingBy: 10) != 0 && n != 0.0 {
                let alert = UIAlertController(title:"Out of SAT Range", message: "The number you typed is impossible to get on an SAT", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            } else {
                satEnglish = Int(n)
            }
        }
        if mathTextField.text != nil {
            let n = formatter.number(from: mathTextField.text!) as! Double
            if  n > 800.0 && n < 200.0 && n.truncatingRemainder(dividingBy: 10) != 0 && n != 0.0 {
                let alert = UIAlertController(title:"Out of SAT Range", message: "The number you typed is impossible to get on an SAT", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            } else {
                satMath = Int(n)
            }
        }
            
        if writingTextField.text != nil && writingTextField.text! != "" {
            let n = formatter.number(from: writingTextField.text!) as! Double
            if n > 18 && n < 6 {
                let alert = UIAlertController(title: "Out of SAT Range", message: "The number you typed is impossible to get on an SAT", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            } else {
                satWriting = Int(n)
            }
        }
        
        
        if englishTextField.text == nil || mathTextField.text == nil {
            let alert = UIAlertController(title:"Invalid Score", message: "Please type in a valid score.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        } else {
            cancelAddbtnPressed(self)
            User.addTakenSAT(english: satEnglish, math: satMath, writing: satWriting)
        }
    }
    
    func ifAddACT() {
        let formatter = NumberFormatter()
        
        var actEnglish = Double()
        var actReading = Double()
        var actMath    = Double()
        var actWriting = Double()
        var actScience = Double()
        
        if englishTextField.text != nil{
            let n = formatter.number(from: englishTextField.text!) as! Double
            if n > 36 && n < 1 && n != 0.0 {
                let alert = UIAlertController(title:"Out of ACT Range", message: "The number you typed is impossible to get on an ACT", preferredStyle: .alert)
               
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
               
                self.present(alert, animated: true)
            } else {
                actEnglish = n
            }
        }
        if readingTextField.text != nil{
            let n = formatter.number(from: readingTextField.text!) as! Double
            if n > 36 && n < 1 && n != 0.0 {
                let alert = UIAlertController(title:"Out of ACT Range", message: "The number you typed is impossible to get on an ACT", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                      
                self.present(alert, animated: true)
            } else {
                actReading = n
            }
        }
        if mathTextField.text != nil {
            let n = formatter.number(from: mathTextField.text!) as! Double
            if  n > 36 && n < 1 && n != 0.0 {
                let alert = UIAlertController(title:"Out of ACT Range", message: "The number you typed is impossible to get on an ACT", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            } else {
                actMath = n
            }
        }
        if scienceTextField.text != nil{
            let n = formatter.number(from: scienceTextField.text!) as! Double
            if n > 36 && n < 1 && n != 0.0 {
                let alert = UIAlertController(title:"Out of ACT Range", message: "The number you typed is impossible to get on an ACT", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                      
                self.present(alert, animated: true)
            } else {
                actScience = n
            }
        }
        if writingTextField.text != nil {
            let n = formatter.number(from: writingTextField.text!) as! Double
            if n > 36 && n < 1 {
                let alert = UIAlertController(title: "Out of SAT Range", message: "The number you typed is impossible to get on an SAT", preferredStyle: .alert)
                    
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            } else {
                actWriting = n
            }
        }
           
           
        if englishTextField.text == nil || mathTextField.text == nil {
            let alert = UIAlertController(title:"Invalid Score", message: "Please type in a valid score.", preferredStyle: .alert)
           
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
           
            self.present(alert, animated: true)
        } else {
            User.addTakenACTs(english: actEnglish, reading: actReading, math: actMath, science: actScience, writing: actWriting)
            cancelAddbtnPressed(self)
        }
    }
    
    
    @IBAction func cancelAddbtnPressed(_ sender: Any){
        UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            self.transparentView.alpha = 0.0
        }, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
           self.transparentView.isHidden = true
       }
    }
    
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if indexPath.section == 1 {
            cell.textLabel!.text = "SAT - English: \(User.getTakenSATs()[indexPath.row].english)  Math: \(User.getTakenSATs()[indexPath.row].math)  Total: \(User.getTakenSATs()[indexPath.row].total)"
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerTitles.count
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame: CGRect = tableView.frame
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        
        let headerTitle = UILabel(frame: CGRect(x: 10, y: 0, width: frame.size.width - 40, height: 20))
        headerTitle.text = headerTitles[section]
        headerTitle.textColor = .white
        
        headerView.addSubview(headerTitle)
        
        let btnAdd = UIButton(frame: CGRect(x: frame.size.width - 30, y: 0, width: 20, height: 20))
        btnAdd.setTitle("+", for: .normal)
        btnAdd.accessibilityIdentifier = "\(section)"
        btnAdd.addTarget(self, action: #selector(addBtnPressed) , for: .touchUpInside)
                
        headerView.addSubview(btnAdd)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    @objc func addBtnPressed(_ sender: UIButton?) {
        
        if sender?.accessibilityIdentifier == "0" /*colleges*/ {
            
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

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.isEmpty{ return true }
        
        let currentText = textField.text ?? ""
        let replacementText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        
        return replacementText.isValidDouble(maxDecimalPlaces: 2)
        
    }
}

extension String {
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
