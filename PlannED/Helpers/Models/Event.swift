//
//  Event.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 6/26/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//

import SwiftUI

final class Event: ObservableObject {
    
    private var id = String()
    private var name = String()
    private var description = String()
    private var date = String()
    
    private static var idList = ["Normal", "SAT", "ACT", "College"]
    
    // MARK: initializeEvent
    func initializeEvent(eventType: String, eventName: String, eventDescription: String, eventDate: String) {
        id = eventType
        name = eventName
        description = eventDescription
        date = eventDate
    }
    
    // MARK: getter functions
    static func getEventTypeList() -> [String] {
        return Event.idList
    }
    
    func getEventType() -> String {
        return id
    }
    
    func getName() -> String{
        return name
    }
    
    func getDescription() -> String{
        return description
    }
    
    func getEventDate() -> String{
        return date
    }
    
    
    
}
