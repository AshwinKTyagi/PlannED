//
//  ChecklistViewController.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 8/20/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//
import GoogleMobileAds
import SwiftUI

class ChecklistViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var adContainer: UIView!
    
    
    lazy var adBannerView: GADBannerView = {
        let adBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        adBannerView.adUnitID = "ca-app-pub-8501671653071605/1974659335"
        adBannerView.delegate = self
        adBannerView.rootViewController = self
        
        return adBannerView
    }()
    
    var collegeEvents = [String]()
    var plannedSatEvents = [Event]()
    var plannedActEvents = [Event]()
    
    let helper = Helper()
    
    let headerTitles = ["Colleges", "SATs", "ACTs"]
    let collegeToDos = ["Create Application Profile", "Personal Info", "Input Tests", "Extra Curriculars", "Essays", "Apply"  ]
    
    var collapsed = [Bool]()
    var selectedIndexPath = [IndexPath]()
    var extraHeight = CGFloat()
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        
        tableView.accessibilityValue = "tableView"
        
        collegeEvents = User.getChosenCollegeNames()
        
        for e in helper.getEvents() {
            if e.id == "SAT" {
                var containsDuplicate = false
                for s in plannedSatEvents{
                    if s.name == e.name && s.date == e.date {
                        containsDuplicate = true
                        break
                    }
                }
                if !containsDuplicate {
                    plannedSatEvents.append(e)
                }
            }
            else if e.id == "ACT"{
                var containsDuplicate = false
                for a in plannedActEvents{
                    if a.name == e.name && a.date == e.date {
                        containsDuplicate = true
                        break
                    }
                }
                if !containsDuplicate {
                    plannedActEvents.append(e)
                }
            }
        }
        
        adBannerView.load(GADRequest())
               
    }
    
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collegeEvents = User.getChosenCollegeNames()
        
	        for e in helper.getEvents() {
            if e.id == "SAT" {
                var containsDuplicate = false
                for s in plannedSatEvents{
                    if s.name == e.name && s.date == e.date {
                        containsDuplicate = true
                        break
                    }
                }
                if !containsDuplicate {
                    plannedSatEvents.append(e)
                }
            }
            else if e.id == "ACT"{
                var containsDuplicate = false
                for a in plannedActEvents{
                    if a.name == e.name && a.date == e.date {
                        containsDuplicate = true
                        break
                    }
                }
                if !containsDuplicate {
                    plannedActEvents.append(e)
                }
            }
        }
        
        
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
    
    // MARK: tableView: numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.accessibilityValue == "subView"{
            return 3
        }
        else if section == 0 {
            return collegeEvents.count
        }
        else if section == 1 {
            return plannedSatEvents.count
        }
        else {
            return plannedActEvents.count
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
            return 50
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
            
        let checkBox = UIButton(frame: CGRect(x: 10, y: 17.5, width: 15, height: 15))
        checkBox.setImage(UIImage(systemName: "square"), for: .normal)
        checkBox.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        checkBox.tintColor = .white
        checkBox.addTarget(self, action: #selector(checkBoxPressed), for: .touchUpInside)

        let labelView = UILabel(frame: CGRect(x: 30, y: 0, width: frame.width - 20, height: 50))
        labelView.textColor = .white
      
        if indexPath.section == 1 {
            labelView.text = plannedSatEvents[indexPath.row].date + ": " + plannedSatEvents[indexPath.row].name
        }
        else {
            labelView.text = plannedActEvents[indexPath.row].date + ": " + plannedActEvents[indexPath.row].name
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
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 30))
        headerView.backgroundColor = UIColor(red: 75/255, green: 1/255, blue: 100/255, alpha: 1)
        
        let headerTitle = UILabel(frame: CGRect(x: 10, y: 5, width: frame.size.width - 40, height: 20))
        headerTitle.text = headerTitles[section]
        headerTitle.textColor = .white
        
        headerView.addSubview(headerTitle)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
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

// MARK: EXTENSION: 
extension ChecklistViewController: GADBannerViewDelegate{
    
    /// Tells the delegate an ad request loaded an ad.
    // MARK: adViewDidReceiveAd
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd - Checklist")
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
