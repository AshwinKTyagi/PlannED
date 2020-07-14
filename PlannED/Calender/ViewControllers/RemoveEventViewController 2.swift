//
//  RemoveEventViewController.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 7/7/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//
import UIKit

class RemoveEventViewController: UIViewController {
    
    @IBOutlet weak var btnSelectEventType: UIButton!
    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var dateSelecter: UIDatePicker!
    @IBOutlet weak var stackView: UIStackView!
    
    let transparentView = UIView()
    let tableView = UITableView()
    let userData = UserData()
    
    var selectedButton = UIButton()
    var dataSource = [String]()
    var selectedDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        eventTableView.delegate = self
        eventTableView.dataSource = self
        
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        
        stackView.isHidden = true
        
        dataSource = Event.getEventTypeList()
        
    }
    
    @IBAction func onClickEventTypeSelection(_ sender: Any) {
        selectedButton = btnSelectEventType
        addTransparentView(frames: btnSelectEventType.frame)
        
    }
    
    @IBAction func datePicked(_ sender: Any) {
        selectedDate = dateSelecter.date
        eventTableView.reloadData()
    }
    
    //sets up and executes dropdown for a button that is passed in
    func addTransparentView(frames: CGRect){
        
        transparentView.frame = self.view.frame
        self.view.addSubview(transparentView)
        
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        
        tableView.reloadData()
        
        let tapgesture = UITapGestureRecognizer(target: self, action:
            #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: CGFloat(self.dataSource.count * 50))
        }, completion: nil)
        
    }
        
        //removes dropdown bar from screen
    @objc func removeTransparentView() {
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
    
    
}


extension RemoveEventViewController: UITableViewDelegate, UITableViewDataSource{
    
    //adds the correct amount of rows to the dropdown
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == self.tableView){
            return dataSource.count
        }
        else if (tableView == eventTableView){
            return userData.getEventNames().count
        }
        return 0
    }
    
    //sets each cell's text label to a date from the data source
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if (tableView == self.tableView){
            cell.textLabel?.text = dataSource[indexPath.row]
            
            return cell
        }
        else if (tableView == eventTableView ) {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-dd-yyyy"
            let string = formatter.string(from: selectedDate)
            
            for e in userData.getEvents() where e.getEventType() == "Normal"{
                if string == e.getEventDate()  {
                    let itemLbl  =  userData.getEventNames()[indexPath.row]
                    
                    cell.textLabel!.text = itemLbl
                    cell.backgroundColor = UIColor.systemIndigo
                    cell.textLabel!.textColor = UIColor.white
                    
                }
            }
            return cell
        }
        eventTableView.reloadData()
        
        return cell
    }
    
    //sets the table row height for the dropdown to be 50
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //sets button label to selected row and saves selection to selectedSATDate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView == self.tableView){
            selectedButton.setTitle(dataSource[indexPath.row], for: .normal)
            
            if btnSelectEventType.currentTitle == "Normal" {
                stackView.isHidden = false
            }
            else if btnSelectEventType.currentTitle == "SAT"{
                let alert = UIAlertController(title:"Are You Sure", message: "This will delete ALL SAT Events. Once this plan is deleted, it can not be retrieved", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                    self.userData.removeSATEvents()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    }))
                self.present(alert, animated: true)
            }
            else if btnSelectEventType.currentTitle == "ACT"{
                let alert = UIAlertController(title:"Are You Sure", message: "This will delete ALL ACT Events. Once this plan is deleted, it can not be retrieved", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                    self.userData.removeACTEvents()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    }))
                self.present(alert, animated: true)
            }
//            else if btnSelectEventType.currentTitle == "College"{
//                let alert = UIAlertController(title:"Are You Sure", message: "This will delete ALL College Events for '\(______)' college. Once this plan is deleted, it can not be retrieved", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
//                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
//                    self.userData.removeCollegeEvents()
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                        self.navigationController?.popToRootViewController(animated: true)
//                    }
//                    }))
//                self.present(alert, animated: true)
//            }
//
            else{
                stackView.isHidden = true
            }
            
            tableView.reloadData()
            removeTransparentView()
        }
        else if (tableView == eventTableView)
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-dd-YYYY"
            let string = formatter.string(from: selectedDate)
            
            let alert = UIAlertController(title:"Are You Sure", message: "Once the event '\(tableView.cellForRow(at: indexPath)?.textLabel?.text ?? "Event")' is deleted, it can not be retrieved", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                self.userData.removeEvent(eventName: (tableView.cellForRow(at: indexPath)?.textLabel?.text)!, eventDate: string)
                }))
            self.present(alert, animated: true)
            
        }
        eventTableView.reloadData()
        
    }
        
}
