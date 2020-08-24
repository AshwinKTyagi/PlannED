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
    
    var subTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.accessibilityValue = "tableView"
        
        collegeEvents = User.getChosenCollegeNames()
        satEvents = helper.getSATDates()
        actEvents = helper.getACTDates()
        
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func checkBoxPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    func collegeSubview(collegeName: String, frame: CGRect, indexPath: IndexPath) -> UIView{
        let sub = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 150))
        sub.backgroundColor = .black
        
        let title = UILabel(frame: CGRect(x: 5, y: 5, width: frame.width - 10, height: 20))
        title.backgroundColor = .black
        title.textColor = .white
        title.text = collegeName
        
        sub.addSubview(title)
        
        let checkBox0 = UIButton(frame: CGRect(x: 10, y: 30, width: 15, height: 15))
        checkBox0.setImage(UIImage(systemName: "square"), for: .normal)
        checkBox0.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        checkBox0.tintColor = .white
        checkBox0.addTarget(self, action: #selector(checkBoxPressed), for: .touchUpInside)

        let checkBox1 = UIButton(frame: CGRect(x: 10, y: 50, width: 15, height: 15))
        checkBox1.setImage(UIImage(systemName: "square"), for: .normal)
        checkBox1.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        checkBox1.tintColor = .white
        checkBox1.addTarget(self, action: #selector(checkBoxPressed), for: .touchUpInside)

        let checkBox2 = UIButton(frame: CGRect(x: 10, y: 70, width: 15, height: 15))
        checkBox2.setImage(UIImage(systemName: "square"), for: .normal)
        checkBox2.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        checkBox2.tintColor = .white
        checkBox2.addTarget(self, action: #selector(checkBoxPressed), for: .touchUpInside)
        
        let checkBox3 = UIButton(frame: CGRect(x: 10, y: 90, width: 15, height: 15))
        checkBox3.setImage(UIImage(systemName: "square"), for: .normal)
        checkBox3.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        checkBox3.tintColor = .white
        checkBox3.addTarget(self, action: #selector(checkBoxPressed), for: .touchUpInside)
        
        let checkBox4 = UIButton(frame: CGRect(x: 10, y: 110, width: 15, height: 15))
        checkBox4.setImage(UIImage(systemName: "square"), for: .normal)
        checkBox4.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        checkBox4.tintColor = .white
        checkBox4.addTarget(self, action: #selector(checkBoxPressed), for: .touchUpInside)
        
        let checkBox5 = UIButton(frame: CGRect(x: 10, y: 130, width: 15, height: 15))
        checkBox5.setImage(UIImage(systemName: "square"), for: .normal)
        checkBox5.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        checkBox5.tintColor = .white
        checkBox5.addTarget(self, action: #selector(checkBoxPressed), for: .touchUpInside)
        
        let itemLabel0 = UILabel(frame: CGRect(x: 30, y: 27.5, width: frame.width - 20, height: 20))
        itemLabel0.textColor = .white
        itemLabel0.text = collegeToDos[0]
       
        let itemLabel1 = UILabel(frame: CGRect(x: 30, y: 47.5, width: frame.width - 20, height: 20))
        itemLabel1.textColor = .white
        itemLabel1.text = collegeToDos[1]
       
        let itemLabel2 = UILabel(frame: CGRect(x: 30, y: 67.5, width: frame.width - 20, height: 20))
        itemLabel2.textColor = .white
        itemLabel2.text = collegeToDos[2]
       
        let itemLabel3 = UILabel(frame: CGRect(x: 30, y: 87.5, width: frame.width - 20, height: 20))
        itemLabel3.textColor = .white
        itemLabel3.text = collegeToDos[3]
       
        let itemLabel4 = UILabel(frame: CGRect(x: 30, y: 107.5, width: frame.width - 20, height: 20))
        itemLabel4.textColor = .white
        itemLabel4.text = collegeToDos[4]
       
        let itemLabel5 = UILabel(frame: CGRect(x: 30, y: 127.5, width: frame.width - 20, height: 20))
        itemLabel5.textColor = .white
        itemLabel5.text = collegeToDos[5]
       
        
        sub.addSubview(checkBox0)
        sub.addSubview(checkBox1)
        sub.addSubview(checkBox2)
        sub.addSubview(checkBox3)
        sub.addSubview(checkBox4)
        sub.addSubview(checkBox5)
        
        sub.addSubview(itemLabel0)
        sub.addSubview(itemLabel1)
        sub.addSubview(itemLabel2)
        sub.addSubview(itemLabel3)
        sub.addSubview(itemLabel4)
        sub.addSubview(itemLabel5)
        
        let topSeperatorLineView = UIView(frame: CGRect(x: 10, y: 0, width: frame.width - 20, height: 0.5))
        topSeperatorLineView.backgroundColor = .white
        
        if indexPath.row != 0 {
            sub.addSubview(topSeperatorLineView)
        }
        
        return sub
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
            return collegeEvents.count
        }
        else if section == 1 {
            return satEvents.count
        }
        else {
            return actEvents.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.tableView && indexPath.section == 0 {
            return 150
        }
        else {
            return 20
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let frame = tableView.frame
        
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = .black
        
        print("\(indexPath)")
        if tableView.accessibilityValue == "subViewCollege" {
            cell.textLabel?.text = collegeToDos[indexPath.row]
        }
        else if indexPath.section == 0 {
            cell.addSubview(collegeSubview(collegeName: collegeEvents[indexPath.row], frame: cell.frame, indexPath: indexPath))
            
            return cell
        }
        else if indexPath.section == 1 {
            print("bleh")
        }
        else {
            print("blah")
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
       let headerView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 50))
       headerView.backgroundColor = UIColor(red: 75/255, green: 1/255, blue: 100/255, alpha: 1)
       
       let headerTitle = UILabel(frame: CGRect(x: 10, y: 10, width: frame.size.width - 40, height: 20))
       headerTitle.text = headerTitles[section]
       headerTitle.textColor = .white
       
       headerView.addSubview(headerTitle)

       return headerView
   }
}
