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
    let helper = Helper()
    
    var selectedButton = UIButton()
    var dataSource = [String]()
    var selectedDate = Date()
    var tempEventArray = [Event]()
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        eventTableView.delegate = self
        eventTableView.dataSource = self
        
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        
        stackView.isHidden = true
        eventTableView.isHidden = true
        
        dataSource = Event.idList
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let tempDate = formatter.string(from: Date())

        for e in helper.getEvents() where e.id == "Normal" && tempDate == e.date{
            tempEventArray.append(e)
        }
        
    }
    
    @IBAction func onClickEventTypeSelection(_ sender: Any) {
        selectedButton = btnSelectEventType
        addTransparentView(frames: btnSelectEventType.frame)
        
    }
    
    // MARK: datePicked
    @IBAction func datePicked(_ sender: Any) {
        selectedDate = dateSelecter.date

        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let tempDate = formatter.string(from: selectedDate)

        tempEventArray = []

        for e in helper.getEvents() where e.id == "Normal" && tempDate == e.date{
            tempEventArray.append(e)
        }
        
        
        eventTableView.reloadData()
    }
    
    //sets up and executes dropdown for a button that is passed in
    // MARK: addTransparentView
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
    // MARK: removeTransparentView
    @objc func removeTransparentView() {
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
    
    
}

// MARK: EXTENSION W/ UITableViewDelegate AND UITableViewDataSource
extension RemoveEventViewController: UITableViewDelegate, UITableViewDataSource{
    
    //adds the correct amount of rows to the dropdown
    // MARK: numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == self.tableView){
            return dataSource.count
        }
        else if (tableView == eventTableView){
            return tempEventArray.count
        }
        return 0
    }
    
    //sets each cell's text label to a date from the data source
    // MARK: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let frame = tableView.frame
        
        let topSeperatorLineView = UIView(frame: CGRect(x: 10, y: 0, width: frame.width - 20, height: 0.5))
        topSeperatorLineView.backgroundColor = .white
        
        if indexPath.row != 0 {
            cell.addSubview(topSeperatorLineView)
        }
        
        if (tableView == self.tableView){
            cell.textLabel?.text = dataSource[indexPath.row]
            
            return cell
        }
        else if (tableView == eventTableView ) {

            cell.backgroundColor = UIColor.systemIndigo
            cell.textLabel!.textColor = UIColor.white
            cell.textLabel!.text = tempEventArray[indexPath.row].name
            
            return cell
        } else {
            return cell
        }
    }
    
    //sets the table row height for the dropdown to be 50
    // MARK: heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //sets button label to selected row and saves selection to selectedSATDate
    // MARK: didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView == self.tableView){
            selectedButton.setTitle(dataSource[indexPath.row], for: .normal)
            
            if btnSelectEventType.currentTitle == "Normal" {
                stackView.isHidden = false
                eventTableView.isHidden = false
            }
            else if btnSelectEventType.currentTitle == "SAT"{
                let alert = UIAlertController(title:"Are You Sure", message: "This will delete ALL SAT Events. Once this plan is deleted, it can not be retrieved", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                    self.helper.removeSATEvents()
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
                    self.helper.removeACTEvents()
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
//                    self.helper.removeCollegeEvents()
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
                self.helper.removeEvent(eventName: (tableView.cellForRow(at: indexPath)?.textLabel?.text)!, eventDate: string)
                self.tempEventArray.remove(at: indexPath.row)
                }))
            self.present(alert, animated: true)
            
        }
        eventTableView.reloadData()
        
    }
        
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if tableView == eventTableView  {
            cell.alpha = 0
            UIView.animate(
                withDuration: 0.5,
                delay: 0.05 * Double(indexPath.row),
                animations: {
                    cell.alpha = 1
            })
            
        }
    }
}
