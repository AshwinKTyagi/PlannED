//
//  AddEventViewController.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 6/25/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//
import UIKit

class AddEventViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var eventDescription: UITextView!
    @IBOutlet weak var eventDatePicker: UIDatePicker!
   
    let helper = Helper()
    
    var eventDates = [String]()
    var selectedDate = Date()
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventDescription.text = "Insert Event Description"
        eventDescription.textColor = .lightGray
        eventDescription.delegate = self
        
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
            
            helper.addEvent(eventType: "Normal", name: eventNameTextField.text!, desc: eventDescription.text!, date: eventDatePicker.date)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.navigationController?.popToRootViewController(animated: true)
            }
        
        //sends an alert if the event name is not filled properly
        } else {
            let alert = UIAlertController(title:"Invalid Event Name", message: "Please fill out the required fields before creating an event", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    
    // MARK: textViewShouldBeginEditing
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        eventDescription.text = ""
        eventDescription.textColor = .black
        return true
    }
    
    
    // MARK: textViewDidChange
    func textViewDidChange(_ textView: UITextView) {
        if eventDescription.text.count == 0 {
            eventDescription.textColor = .lightGray
            eventDescription.text = "Insert Event Description"
            
            eventDescription.resignFirstResponder()
        }
    }
    
    func textViewShouldEndEditing (_ textView: UITextView) -> Bool {
        if eventDescription.text.count == 0 {
            eventDescription.textColor = .lightGray
            eventDescription.text = "Insert Event Description"
            
            eventDescription.resignFirstResponder()
        }
        return true
    }
}
