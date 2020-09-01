//
//  ACTEvent.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 7/8/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//
import SwiftUI

final class ACTEvent: ObservableObject {
    
    private var dateID = String()
    private var regID = String()
    private var ACTDate = String()
    private var registrationDate = String()
    
    // MARK: initializeEvent
    func initializeEvent(dID: String, rID: String, actDate: String, registration: String) {
        
        if rID == "TBD" || registration == "TBD" {
            dateID = dID
            regID = ""
            ACTDate = actDate
            registrationDate = ""
        }
        else{
            dateID = dID
            regID = rID
            ACTDate = actDate
            registrationDate = registration
        }
    }
    
    // MARK: getter functions
    func getDateID() -> String{
        return dateID
    }
    
    func getRegID() -> String {
        return regID
    }
    
    func getACTDate() -> String{
        return ACTDate
    }
    
    func getRegistrationDate() -> String{
        return registrationDate
    }
    
}
