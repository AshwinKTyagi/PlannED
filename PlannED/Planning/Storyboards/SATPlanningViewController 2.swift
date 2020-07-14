//
//  SATPlanningViewController.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 7/3/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//

import UIKit
import MultiSelectSegmentedControl

class CellClass: UITableViewCell {
    
}

class SATPlanningViewController: UIViewController {
    
    @IBOutlet weak var btnSelectSATDate: UIButton!
    @IBOutlet weak var daySelecter: MultiSelectSegmentedControl!
    @IBOutlet weak var setDaySetting: UIStackView!
    @IBOutlet weak var practiceIntensity:UISegmentedControl!
    @IBOutlet weak var btnFinish: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let transparentView = UIView()
    let tableView = UITableView()
    let userData = UserData()
    
    var selectedButton = UIButton()
    var dataSource = [String]()
    
    var selectedSATDate = String()
    var selectedDays = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        
        activityIndicator.isHidden = true
        
        daySelecter.delegate = self
                
        daySelecter.items = ["Sun","Mon","Tue", "Wed", "Thu", "Fri", "Sat"]
        
        //customizes segment bars to have white text for default segments
        var titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        practiceIntensity.setTitleTextAttributes(titleTextAttributes, for: .normal)
        daySelecter.setTitleTextAttributes(titleTextAttributes, for: .normal)
        
        //customizes segment bars to have black text for selected items
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        practiceIntensity.setTitleTextAttributes(titleTextAttributes, for: .selected)
        daySelecter.setTitleTextAttributes(titleTextAttributes, for: .selected)
        
    }
    
    //code for when practice amount is selected (1,2 or 3)
    @IBAction func onPracticeSelection(_ sender: Any){
        let daysPerWeek = practiceIntensity.selectedSegmentIndex + 1
        var selectedSegs = [Int]()
        
        
        var localIndex = 0
        for segs in daySelecter.segments{
            if segs.isSelected{
                selectedSegs.append(localIndex)
            }
            localIndex+=1
        }
        
        localIndex = 0
        
        //resets the weekday bar to match the amount specified
        for selDay in selectedDays{
            if daysPerWeek < selectedDays.count {
                
                daySelecter.segments[selectedSegs[localIndex]].isSelected = false
                
                let selDays = selectedDays.filter { $0 != selDay }
                selectedDays = selDays
                
            }
            else{
                break
            }
            localIndex+=1
        }
    }
    
    //code for when the finish button is pressed
    @IBAction func onClickFinish(_ sender: Any){
        
        activityIndicator.startAnimating()
        
        let daysPerWeek = practiceIntensity.selectedSegmentIndex + 1
        
        //checks for a valid SAT date
        if selectedSATDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty {
            let alert = UIAlertController(title:"Invalid SAT Date", message: "Please choose a SAT Date.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true)
                    
        //checks for a valid number of selected days
        } else if daysPerWeek != selectedDays.count {
            let alert = UIAlertController(title:"Invalid Number of Dates", message: "Please choose the same amount days as you specified.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
        // returns to planning screen after sending SAT Planning Data to UserData
        else {
            let alert = UIAlertController(title:"Are You Ready to Create a Plan", message: "Take a chance to look over your choices. If you are ready click 'Done'", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { action in
                self.userData.addSATPlanning(days: self.selectedDays, date: self.selectedSATDate)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.navigationController?.popToRootViewController(animated: true)
                }
                }))
            
            self.present(alert, animated: true)
            
            
        }
        activityIndicator.stopAnimating()
        
    }
    
    //code for when the SAT Date select button is pressed
    @IBAction func onClickSelectSATDate(_ sender: Any){
        selectedButton = btnSelectSATDate
        dataSource = userData.getSATDates()
        addTransparentView(frames: btnSelectSATDate.frame)
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
        
        var frameHeight = Int()
               
        if dataSource.count > 9{
            frameHeight = 9 * 50
        }
        else {
            frameHeight = dataSource.count * 50
        }
        
        let tapgesture = UITapGestureRecognizer(target: self, action:
            #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: CGFloat(frameHeight))
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

extension SATPlanningViewController: UITableViewDelegate, UITableViewDataSource{
    
    //adds the correct amount of rows to the dropdown
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    //sets each cell's text label to a date from the data source
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = dataSource[indexPath.row]
        
        return cell
    }
    
    //sets the table row height for the dropdown to be 50
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //sets button label to selected row and saves selection to selectedSATDate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedButton.setTitle(dataSource[indexPath.row], for: .normal)
        selectedSATDate = dataSource[indexPath.row]
        
        removeTransparentView()
        
    }
        
}


extension SATPlanningViewController: MultiSelectSegmentedControlDelegate {
    //executes code for when a segment from daySelecter is selected or unselected
    func multiSelect(_ multiSelectSegmentedControl: MultiSelectSegmentedControl, didChange value: Bool, at index: Int) {
        let selectedDay = daySelecter.items[index] as! String
        
        //checks if a chosen cell is unselected and removes it from the selectedDays array
        if !value && selectedDays.contains(selectedDay){
            let selDays = selectedDays.filter { $0 != selectedDay }
            selectedDays = selDays
        }
        //prevents the user from selecting more days than specified by practiceIntesity
        else if selectedDays.count == (practiceIntensity.selectedSegmentIndex + 1){
            daySelecter.segments[index].isSelected = false
        }
        //adds the selectedDay to the selectedDays array
        else if value {
            selectedDays.append(selectedDay)
        }
        //safety net that removes deselected items from selectedDays array
        else {
            let selDays = selectedDays.filter { $0 != selectedDay }
            selectedDays = selDays
        }
            
    }
    

}
