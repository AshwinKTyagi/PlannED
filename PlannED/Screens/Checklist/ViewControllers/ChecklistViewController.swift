//
//  ChecklistViewController.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 8/20/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//

import SwiftUI

class ChecklistViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var collegeEvents = [String]()
    var satEvents = [String]()
    var actEvents = [String]()
    
    let helper = Helper()
    
    let headerTitles = ["Colleges", "SATs", "ACTs"]
    let collegeToDos = ["Create Application Profile", "Personal Info", "Input Tests", "Extra Curriculars", "Essays", "Apply"  ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        collegeEvents = User.getChosenCollegeNames()
        satEvents = helper.getSATDates()
        actEvents = helper.getACTDates()
    }
    
    func subTable(_ type: String, frame: CGRect) -> UITableView{
        var table: UITableView
        if type == "college" {
            table = UITableView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 0))
            table.delegate = self
            table.dataSource = self
            table.accessibilityValue = "subViewCollege"
            
            
        }
        else {
            table = UITableView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 0))
            table.delegate = self
            table.dataSource = self
            table.accessibilityValue = "subView"
        
        }
        
        return table
    }
    
    func collapse(view: UIView, desiredHeight: Double ) {
        let frame = view.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            view.frame = CGRect(x: frame.midX, y: frame.midY, width: frame.width, height: CGFloat(desiredHeight))
        }, completion: nil)
            
    }
}

extension ChecklistViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.accessibilityValue == "subViewCollege"{
            return collegeToDos.count
        }
        else if tableView.accessibilityValue == "subView"{
            return 3
        }
        else if section == 0 {
            return satEvents.count
        }
        else if section == 1 {
            return actEvents.count
        }
        else {
            return collegeEvents.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let frame = tableView.frame
        
        cell.textLabel?.textColor = UIColor.white
        
        if tableView == self.tableView{
            if indexPath.section == 0 {
                
            }
            else if indexPath.section == 1 {
                
            }
            else {
                let sub = subTable("college", frame: frame)
                
                cell.textLabel?.text = collegeEvents[indexPath.row]
                
                cell.addSubview(sub)
            }
        }
        else {
            if tableView.accessibilityValue == "subViewCollege" {
                
            }
        }
        
        let topSeperatorLineView = UIView(frame: CGRect(x: 10, y: 0, width: frame.width - 20, height: 0.5))
        topSeperatorLineView.backgroundColor = .white
        
        if indexPath.row != 0 {
            cell.addSubview(topSeperatorLineView)
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
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

       return headerView
   }
}

