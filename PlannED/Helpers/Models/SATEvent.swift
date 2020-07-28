//
//  SATDates.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 7/4/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//

import SwiftUI

final class SATEvent: ObservableObject {
    
    private var dateID = String()
    private var regID = String()
    private var SATDate = String()
    private var registrationDate = String()
    
    // MARK: initializeEvent
    func initializeEvent(dID: String, rID: String, satDate: String, registration: String) {
        dateID = dID
        regID = rID
        SATDate = satDate
        registrationDate = registration
    }
    
    // MARK: getter functions
    func getDateID() -> String{
        return dateID
    }
    
    func getRegID() -> String {
        return regID
    }
    
    func getSATDate() -> String{
        return SATDate
    }
    
    func getRegistrationDate() -> String{
        return registrationDate
    }
    
}
