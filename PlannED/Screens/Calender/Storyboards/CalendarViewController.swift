//
//  CalendarViewController.swift
//  
//
//  Created by Ashwin Tyagi on 6/23/20.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, UITableViewDataSource, UITableViewDelegate {
        

    @IBOutlet var calendar: FSCalendar!
    @IBOutlet var eventsLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var transparentView: UIView!
    @IBOutlet var eventNameLabel: UILabel!
    @IBOutlet var eventDateLabel: UILabel!
    @IBOutlet var eventDescriptionLabel: UILabel!
    @IBOutlet var btnEventClose: UIButton!
    
    
    var selectedDate = Date()
    var dayEvents = [Event]()
    var dayEventNames = [String]()
    
        
    var userData = UserData()
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        calendar.dataSource = self
        
        calendar.appearance.weekdayTextColor = UIColor.white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
        
        transparentView.alpha = 0
        transparentView.isHidden = true
        
        if let localEventData = userData.readLocalJsonFile(forName: "eventData"), let localCollegeData = userData.readLocalJsonFile(forName: "collegeData"){
            userData.parseForDates(eventJsonData: localEventData, collegeJsonData: localCollegeData)
        }
    }
    
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        calendar.reloadData()
        tableView.reloadData()
        
        calendar.adjustMonthPosition()
    }
    
    
    //code for when a date on the calendar is selected
    // MARK: calendar: didSelect
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let selectedDate = date
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-YYYY"
        let string = formatter.string(from: selectedDate)
        
        eventsLabel.text = "Events: " + string
        
        dayEvents = []
        dayEventNames = []
        
        
        //updates tableView to show the events on the date selected
        if userData.getEventDates().contains(string) {
            for event in userData.getEvents(){
                if event.getEventDate() == string{
                    dayEvents.append(event)
                    dayEventNames.append(event.getName())
                        
                    
                }
            }
        }
        
        tableView.reloadData()
    }
    
    //sets the FSCalenar's frame to be correct in terms of the storyboard
    // MARK: calendar: boundingRectWillChange
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    
    //displays a dot if a date has an event
    // MARK: calendar: numberOfEventsFor
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-YYYY"
        let string = formatter.string(from: date)
        
        var count = 0
        for e in userData.getEvents(){
            if e.getEventDate() == string {
                count += 1
            }
        }
        return count
    }

    //sets the correct number of items in the table view
    // MARK: tableView: numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let val = dayEventNames.count
        
        return val
    }
    
    // initializes data for selected date
    // MARK: tableView: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemLbl  =  dayEventNames[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        

        cell.textLabel!.text = itemLbl
        cell.backgroundColor = UIColor.systemIndigo
        cell.textLabel!.textColor = UIColor.white
        return cell
    }
    
    //displays information for selected cell
    // MARK: tableView: didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        for e in userData.getEvents(){
            if e.getName() == tableView.cellForRow(at: indexPath)?.textLabel!.text{
                eventNameLabel.text = e.getName()
                eventDateLabel.text = e.getEventDate()
                
                if e.getDescription().isEmpty {
                    eventDescriptionLabel.text = "No description"
                }
                else {
                    eventDescriptionLabel.text = e.getDescription()
                }
            }
        }
        UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            self.transparentView.isHidden = false
            self.transparentView.alpha = 1.0
        }, completion: nil)
        
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
    
    //closes the transparent view
    // MARK: onClickEventCloseButton
    @IBAction func onClickEventCloseButton(_ sender: Any?){
        UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            self.transparentView.alpha = 0.0
        }, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.transparentView.isHidden = true
        }
    }
    

    
}
