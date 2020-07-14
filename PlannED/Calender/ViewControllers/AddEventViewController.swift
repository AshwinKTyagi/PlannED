//
//  AddEventViewController.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 6/25/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//
import UIKit

class AddEventViewController: UIViewController {
    
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var eventDescription: UITextField!
    @IBOutlet weak var eventDatePicker: UIDatePicker!
    @IBOutlet weak var doneSegue: UIStoryboardSegue!
    
    let userData = UserData()
    
    var eventDates = [String]()
    var selectedDate = Date()
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //code for when the done button is pressed
    // MARK: doneButtonTapped
    @IBAction func doneButtonTapped(sender: UIBarButtonItem) {
        
        if let text = eventNameTextField.text, !text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty {
            //sends information to User Data to create an event
            selectedDate = eventDatePicker.date
            
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-dd-YYYY"
            let string = formatter.string(from: selectedDate)
            
            eventDates.append(string)
            
            userData.addEvent(eventType: "Normal", name: eventNameTextField.text!, desc: eventDescription.text!, date: eventDatePicker.date)
            
            performSegue(withIdentifier: "doneSegue", sender: sender)
        
        //sends an alert if the event name is not filled properly
        } else {
            let alert = UIAlertController(title:"Invalid Event Name", message: "Please fill out the required fields before creating an event", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    
    

}
