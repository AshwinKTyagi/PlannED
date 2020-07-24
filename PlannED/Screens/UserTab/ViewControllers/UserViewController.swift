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
            if englishTextField.text == nil  || (englishTextField as? Int ?? 0) > 800{
                
            }
            else if mathTextField.text == nil {
                
            }
            else {
                
            }
        }
    }
    
    @IBAction func cancellAddbtnPressed(_ sender: Any){
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
        return 50.0
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
        if string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil {
            return true
        } else {
            return false
        }
    }
}
