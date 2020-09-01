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
    
    var collapsed = [Bool]()
    var selectedIndexPath = [IndexPath]()
    var extraHeight = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        
        tableView.accessibilityValue = "tableView"
        
        collegeEvents = User.getChosenCollegeNames()
        satEvents = helper.getSATDates()
        actEvents = helper.getACTDates()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collegeEvents = User.getChosenCollegeNames()
        satEvents = helper.getSATDates()
        actEvents = helper.getACTDates()
        tableView.reloadData()
    }
    
    // MARK: didRecieveMemoryWarning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: checkBoxPressed
    @objc func checkBoxPressed(_ sender: UIButton) {
        let stringArr = sender.accessibilityIdentifier?.split(separator: ".")
        let formatter = NumberFormatter()
        let index = formatter.number(from: String(stringArr![1])) as! Int
        let checkboxIndex = formatter.number(from: String(stringArr![3])) as! Int
        
        
        print(collegeEvents[index])
        
        User.setChosenCollegeChecklist(index: index, checklistIndex: checkboxIndex, value: !sender.isSelected)
        
        sender.isSelected = !sender.isSelected
    }
    
    // MARK: collegeSubview
    func collegeSubview(collegeName: String, frame: CGRect, indexPath: IndexPath) -> UIView{
        let checklist = User.getChosenColleges()[indexPath.row].checklist
        
        let sub = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 150))
        sub.backgroundColor = .black
        sub.accessibilityIdentifier = "\(indexPath)sub"
        
        let title = UILabel(frame: CGRect(x: 5, y: 5, width: frame.width - 10, height: 20))
        title.backgroundColor = .black
        title.textColor = .white
        title.text = collegeName
        title.accessibilityIdentifier = "\(indexPath)title"
        
        sub.addSubview(title)
        
        let checkBox0 = UIButton(frame: CGRect(x: 15, y: 30, width: 15, height: 15))
        checkBox0.setImage(UIImage(systemName: "square"), for: .normal)
        checkBox0.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        checkBox0.tintColor = .white
        checkBox0.accessibilityIdentifier = "\(indexPath.section).\(indexPath.row).check.0"
        checkBox0.addTarget(self, action: #selector(checkBoxPressed), for: .touchUpInside)
        checkBox0.isSelected = checklist[0]

        let checkBox1 = UIButton(frame: CGRect(x: 15, y: 50, width: 15, height: 15))
        checkBox1.setImage(UIImage(systemName: "square"), for: .normal)
        checkBox1.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        checkBox1.tintColor = .white
        checkBox1.accessibilityIdentifier = "\(indexPath.section).\(indexPath.row).check.1"
        checkBox1.addTarget(self, action: #selector(checkBoxPressed), for: .touchUpInside)
        checkBox1.isSelected = checklist[1]

        let checkBox2 = UIButton(frame: CGRect(x: 15, y: 70, width: 15, height: 15))
        checkBox2.setImage(UIImage(systemName: "square"), for: .normal)
        checkBox2.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        checkBox2.tintColor = .white
        checkBox2.accessibilityIdentifier = "\(indexPath.section).\(indexPath.row).check.2"
        checkBox2.addTarget(self, action: #selector(checkBoxPressed), for: .touchUpInside)
        checkBox2.isSelected = checklist[2]
        
        let checkBox3 = UIButton(frame: CGRect(x: 15, y: 90, width: 15, height: 15))
        checkBox3.setImage(UIImage(systemName: "square"), for: .normal)
        checkBox3.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        checkBox3.tintColor = .white
        checkBox3.accessibilityIdentifier = "\(indexPath.section).\(indexPath.row).check.3"
        checkBox3.addTarget(self, action: #selector(checkBoxPressed), for: .touchUpInside)
        checkBox3.isSelected = checklist[3]
        
        let checkBox4 = UIButton(frame: CGRect(x: 15, y: 110, width: 15, height: 15))
        checkBox4.setImage(UIImage(systemName: "square"), for: .normal)
        checkBox4.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        checkBox4.tintColor = .white
        checkBox4.accessibilityIdentifier = "\(indexPath.section).\(indexPath.row).check.4"
        checkBox4.addTarget(self, action: #selector(checkBoxPressed), for: .touchUpInside)
        checkBox4.isSelected = checklist[4]
        
        let checkBox5 = UIButton(frame: CGRect(x: 15, y: 130, width: 15, height: 15))
        checkBox5.setImage(UIImage(systemName: "square"), for: .normal)
        checkBox5.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        checkBox5.tintColor = .white
        checkBox5.accessibilityIdentifier = "\(indexPath.section).\(indexPath.row).check.5"
        checkBox5.addTarget(self, action: #selector(checkBoxPressed), for: .touchUpInside)
        checkBox5.isSelected = checklist[5]
        
        let itemLabel0 = UILabel(frame: CGRect(x: 35, y: 27.5, width: frame.width - 20, height: 20))
        itemLabel0.textColor = .white
        itemLabel0.text = collegeToDos[0]
       
        let itemLabel1 = UILabel(frame: CGRect(x: 35, y: 47.5, width: frame.width - 20, height: 20))
        itemLabel1.textColor = .white
        itemLabel1.text = collegeToDos[1]
       
        let itemLabel2 = UILabel(frame: CGRect(x: 35, y: 67.5, width: frame.width - 20, height: 20))
        itemLabel2.textColor = .white
        itemLabel2.text = collegeToDos[2]
       
        let itemLabel3 = UILabel(frame: CGRect(x: 35, y: 87.5, width: frame.width - 20, height: 20))
        itemLabel3.textColor = .white
        itemLabel3.text = collegeToDos[3]
       
        let itemLabel4 = UILabel(frame: CGRect(x: 35, y: 107.5, width: frame.width - 20, height: 20))
        itemLabel4.textColor = .white
        itemLabel4.text = collegeToDos[4]
       
        let itemLabel5 = UILabel(frame: CGRect(x: 35, y: 127.5, width: frame.width - 20, height: 20))
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
                
        return sub
    }
    
    // MARK: collapse
    func collapse(view: UIView, desiredHeight: Double ) {
        let frame = view.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveLinear, animations: {
            view.frame = CGRect(x: frame.midX, y: frame.midY, width: frame.width, height: CGFloat(desiredHeight))
        }, completion: nil)
            
    }
}

extension ChecklistViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: tableView: snumberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.accessibilityValue == "subView"{
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
    
    // MARK: tableView: heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.tableView && indexPath.section == 0 {
            if selectedIndexPath.contains(indexPath) {
                return 150 + extraHeight
            }
                return 150
        }
        else {
            return 30
        }
    }
    
    // MARK: tableView: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellClass
        let frame = tableView.frame
        
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = .black
        
        if indexPath.section == 0 {
            cell.addSubview(collegeSubview(collegeName: collegeEvents[indexPath.row], frame: cell.frame, indexPath: indexPath))
            collapsed.append(false)

            let topSeperatorLineView = UIView(frame: CGRect(x: 10, y: 0, width: frame.width - 20, height: 0.5))
            topSeperatorLineView.backgroundColor = .white
            topSeperatorLineView.accessibilityIdentifier = "\(indexPath)topSeperator"
            
            if indexPath.row != 0 {
                cell.addSubview(topSeperatorLineView)
            }
            
            let tl = UILabel(frame: CGRect(x: 5, y: 0, width: tableView.frame.width - 40, height: 0))
            
            tl.isHidden = true
            tl.text = collegeEvents[indexPath.row]
            tl.accessibilityIdentifier = "\(indexPath)tl"
            tl.textColor = .white
            cell.addSubview(tl)
            
            return cell
        }
        else {
            for v in cell.subviews {
                v.removeFromSuperview()
            }
        }
            
        let checkBox = UIButton(frame: CGRect(x: 10, y: 7.5, width: 15, height: 15))
        checkBox.setImage(UIImage(systemName: "square"), for: .normal)
        checkBox.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        checkBox.tintColor = .white
        checkBox.addTarget(self, action: #selector(checkBoxPressed), for: .touchUpInside)

        let labelView = UILabel(frame: CGRect(x: 30, y: 0, width: frame.width - 20, height: 30))
        labelView.textColor = .white
      
        if indexPath.section == 1 {
            labelView.text = "SAT: " + satEvents[indexPath.row]
        }
        else {
            labelView.text = "ACT: " + actEvents[indexPath.row]
        }
        
        let topSeperatorLineView = UIView(frame: CGRect(x: 10, y: 0, width: frame.width - 20, height: 0.5))
        topSeperatorLineView.backgroundColor = .white
        
        if indexPath.row != 0 {
            cell.addSubview(topSeperatorLineView)
        }
        
        cell.addSubview(labelView)
        cell.addSubview(checkBox)
        
        return cell
    }
    
    
    // MARK: numberOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    // MARK: tableView: viewForHeaderInSection
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame: CGRect = tableView.frame
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 50))
        headerView.backgroundColor = UIColor(red: 75/255, green: 1/255, blue: 100/255, alpha: 1)
        
        let headerTitle = UILabel(frame: CGRect(x: 10, y: 5, width: frame.size.width - 40, height: 20))
        headerTitle.text = headerTitles[section]
        headerTitle.textColor = .white
        
        headerView.addSubview(headerTitle)

        return headerView
    }
    
    // MARK: tableView: didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath)")
        
        if indexPath.section == 0 {
            if !collapsed[indexPath.row]{
                if let cell = tableView.cellForRow(at: indexPath) as? CellClass {

                    selectedIndexPath.append(indexPath)
                    extraHeight = -120

                    tableView.beginUpdates()
                    tableView.endUpdates()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                        for v in cell.subviews {
                            v.isHidden = true
                            if v.accessibilityIdentifier == "\(indexPath)topSeperator"  {
                                v.isHidden = false
                            }
                            else if v.accessibilityIdentifier == "\(indexPath)tl" {
                                v.isHidden = false
                                v.frame = CGRect(x: 5, y: 0, width: tableView.frame.width - 40, height: 30)
                            }
                            
                        }
                        
                    })
                    
                        
                }
                collapsed[indexPath.row] = true
            }
            else {
                if let cell = tableView.cellForRow(at: indexPath) as? CellClass{
                    
                    var i = Int()
                    for index in selectedIndexPath {
                        if index == indexPath{
                            selectedIndexPath.remove(at: i)
                        }
                        i += 1
                    }
                    
                    tableView.beginUpdates()
                    tableView.endUpdates()
                    
                    for v in cell.subviews {
                        if v.accessibilityIdentifier == "\(indexPath)sub"{
                            v.isHidden = false
                        }
                        else if v.accessibilityIdentifier == "\(indexPath)tl" {
                            v.isHidden = true
                            v.frame = CGRect(x: 5, y: 0, width: tableView.frame.width - 40, height: 0)
                        }

                    }

                    collapsed[indexPath.row] = false
                }
            }
        }
    }
}

