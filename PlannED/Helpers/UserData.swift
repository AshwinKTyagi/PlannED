//
//  UserData.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 6/26/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//

import Combine
import SwiftUI
import EventKit
import UIKit
import FSCalendar

final class UserData: ObservableObject {
    
    private static var events = [Event]()
    private static var satEvents = [SATEvent]()
    private static var actEvents = [ACTEvent]()
    private static var colleges = [College]()
    
    
    //generic addEvent method that accepts date as a Date and formats it into a String
    func addEvent(eventType: String, name: String, desc: String, date: Date) {
        
        let event = Event()
        
        let d = date
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let string = formatter.string(from: d)
        
        event.initializeEvent(eventType: eventType, eventName: name, eventDescription: desc, eventDate: string)
        
        UserData.events.append(event)
        
    }
    
    //generic addEvent method that accepts date as a String
    func addEvent(eventType: String, name: String, desc: String, date: String) {
        
        let event = Event()
        
        event.initializeEvent(eventType: eventType, eventName: name, eventDescription: desc, eventDate: date)
        
        UserData.events.append(event)
        
    }
    
    //generic addSATEvent
    func addSATEvent(dID: String, rID: String, date: String, reg: String) {
        
        let event = SATEvent()
        
        event.initializeEvent(dID: dID, rID: rID, satDate: date, registration: reg)
        
        UserData.satEvents.append(event)
        
    }
    
    //generic addACTEvent
    func addACTEvent(dID: String, rID: String, date: String, reg: String) {
        
        let event = ACTEvent()
        
        event.initializeEvent(dID: dID, rID: rID, actDate: date, registration: reg)
        
        UserData.actEvents.append(event)
        
    }
    
    func satPracticePlanningHelper(nDays: Int, count: Int, cDate: Date, tDate: Date) -> Int{
        var tempDate = tDate
        var numDays = nDays
        
        if numDays + 1 < count{
            while cDate < tempDate{
                addEvent(eventType: "SAT", name: "SAT Practice", desc: "Make sure to get in at least 30 minutes of practice. We reccommend using KhanAcademy; however, do whatever is most effective for you.", date: tempDate)
                tempDate.addTimeInterval(-7*24*60*60)
            }
            numDays += 1
        }
        else if numDays + 1 == count{
            while cDate < tempDate{
                addEvent(eventType: "SAT", name: "SAT Practice Test", desc: "It is suggested to take a practice SAT test today. This will help you get more familiar with the test. We reccommend using KhanAcademy's free SAT tests. If you have finished all available tests, try to go over your  previous tests to understand how to not get similar questions wrong in the future", date: tempDate)
                tempDate.addTimeInterval(-7*24*60*60)
            }
            numDays += 1
        }
        
        return numDays
    }
    
    func actPracticePlanningHelper(nDays: Int, count: Int, cDate: Date, tDate: Date, eDate: Date) -> Int{
        var tempDate = tDate
        var numDays = nDays
        
        if numDays + 1 < count{
            while eDate > tempDate{
                addEvent(eventType: "ACT", name: "ACT Practice", desc: "", date: tempDate)
                tempDate.addTimeInterval(7*24*60*60)
            }
            numDays += 1
        }
        else if numDays + 1 == count{
            while eDate > tempDate{
                addEvent(eventType: "ACT", name: "ACT Practice Test", desc: "", date: tempDate)
                tempDate.addTimeInterval(7*24*60*60)
            }
            numDays += 1
        }
        
        return numDays
    }
    
    
    //sets up Planning for SAT using selected weekdays and a test
    func addACTPlanning(days: [String], date: String) {
        
        var actDateID = String()
        var actRegID = String()
        var actRegistration = String()
        
        //adds events for actual SAT and Registration
        for a in UserData.actEvents {
            if date == a.getACTDate(){
                actDateID = a.getDateID()
                actRegID = a.getRegID()
                actRegistration = a.getRegistrationDate()
            }
        }
        
        if actRegistration == "" {
            actRegistration = "the date provided on the ACT website"
        }
        
        addEvent(eventType: "ACT", name: "ACT Registration Deadline", desc: "Registration Date for the \(date) ACT.", date: actRegID)
        addEvent(eventType: "ACT", name: "ACT", desc: "This is the ACT date that you have been planning for. Be sure to register by \(actRegistration).", date: actDateID)
        
        let endDate = actDateID.toDate(withFormat: "MM/dd/yyyy")
        let currentDate = Date()
        
        let calendar = Calendar(identifier: .gregorian)
        
        var numDays = 0
        
        if days.contains("Sun"){
            // Weekday units are the numbers 1 through n, where n is the number of days in the week.
            // For example, in the Gregorian calendar, n is 7 and Sunday is represented by 1.
            let weekday = 1 // Sunday
            let sundayComponents = DateComponents(calendar: calendar, weekday: weekday)

            let tempDate = calendar.nextDate(after: currentDate, matching: sundayComponents, matchingPolicy: .nextTimePreservingSmallerComponents)
            
            numDays = actPracticePlanningHelper(nDays: numDays, count: days.count, cDate: currentDate, tDate: tempDate!, eDate: endDate)
        }
        if days.contains("Mon"){
            // Weekday units are the numbers 1 through n, where n is the number of days in the week.
            // For example, in the Gregorian calendar, n is 7 and Sunday is represented by 1.
            let weekday = 2 // Sunday
            let sundayComponents = DateComponents(calendar: calendar, weekday: weekday)

            let tempDate = calendar.nextDate(after: currentDate, matching: sundayComponents, matchingPolicy: .nextTimePreservingSmallerComponents)
            
            numDays = actPracticePlanningHelper(nDays: numDays, count: days.count, cDate: currentDate, tDate: tempDate!, eDate: endDate)
        }
        if days.contains("Tue"){
            // Weekday units are the numbers 1 through n, where n is the number of days in the week.
            // For example, in the Gregorian calendar, n is 7 and Sunday is represented by 1.
            let weekday = 3 // Sunday
            let sundayComponents = DateComponents(calendar: calendar, weekday: weekday)

            let tempDate = calendar.nextDate(after: currentDate, matching: sundayComponents, matchingPolicy: .nextTimePreservingSmallerComponents)
            
            numDays = actPracticePlanningHelper(nDays: numDays, count: days.count, cDate: currentDate, tDate: tempDate!, eDate: endDate)
        }
        if days.contains("Wed"){
            // Weekday units are the numbers 1 through n, where n is the number of days in the week.
            // For example, in the Gregorian calendar, n is 7 and Sunday is represented by 1.
            let weekday = 4 // Sunday
            let sundayComponents = DateComponents(calendar: calendar, weekday: weekday)

            let tempDate = calendar.nextDate(after: currentDate, matching: sundayComponents, matchingPolicy: .nextTimePreservingSmallerComponents)
            
            numDays = actPracticePlanningHelper(nDays: numDays, count: days.count, cDate: currentDate, tDate: tempDate!, eDate: endDate)
        }
        if days.contains("Thu"){
            // Weekday units are the numbers 1 through n, where n is the number of days in the week.
            // For example, in the Gregorian calendar, n is 7 and Sunday is represented by 1.
            let weekday = 5 // Sunday
            let sundayComponents = DateComponents(calendar: calendar, weekday: weekday)

            let tempDate = calendar.nextDate(after: currentDate, matching: sundayComponents, matchingPolicy: .nextTimePreservingSmallerComponents)
            
            numDays = actPracticePlanningHelper(nDays: numDays, count: days.count, cDate: currentDate, tDate: tempDate!, eDate: endDate)
        }
        if days.contains("Fri"){
            // Weekday units are the numbers 1 through n, where n is the number of days in the week.
            // For example, in the Gregorian calendar, n is 7 and Sunday is represented by 1.
            let weekday = 6 // Sunday
            let sundayComponents = DateComponents(calendar: calendar, weekday: weekday)

            let tempDate = calendar.nextDate(after: currentDate, matching: sundayComponents, matchingPolicy: .nextTimePreservingSmallerComponents)
            
            numDays = actPracticePlanningHelper(nDays: numDays, count: days.count, cDate: currentDate, tDate: tempDate!, eDate: endDate)
        }
        if days.contains("Sat"){
            // Weekday units are the numbers 1 through n, where n is the number of days in the week.
            // For example, in the Gregorian calendar, n is 7 and Sunday is represented by 1.
            let weekday = 7 // Sunday
            let sundayComponents = DateComponents(calendar: calendar, weekday: weekday)

            let tempDate = calendar.nextDate(after: currentDate, matching: sundayComponents, matchingPolicy: .nextTimePreservingSmallerComponents)
            
            numDays = actPracticePlanningHelper(nDays: numDays, count: days.count, cDate: currentDate, tDate: tempDate!, eDate: endDate)
        }

        
        
        print("ACT Planning success")
    }
    
    func addSATPlanning(days: [String], date: String) {
        
        var satDateID = String()
        var satRegID = String()
        var satRegistration = String()
        
        //adds events for actual SAT and Registration
        for s in UserData.satEvents {
            if date == s.getSATDate(){
                satDateID = s.getDateID()
                satRegID = s.getRegID()
                satRegistration = s.getRegistrationDate()
            }
        }
        
        addEvent(eventType: "SAT", name: "SAT Registration Deadline", desc: "Registration Date for the \(date) SAT", date: satRegID)
        addEvent(eventType: "SAT", name: "SAT", desc: "This is the SAT date that you have been planning for. Be sure to register by \(satRegistration).", date: satDateID)
        
        let endDate = satDateID.toDate(withFormat: "MM/dd/yyyy")
        let currentDate = Date()
        
        var numDays = 0
        
        if days.contains("Sun") {
            //gets the last Sunday before the selected sat date assuming all sats are on Saturdays. If College Board changes the day make sure to update it here
            let tempDate = endDate.addingTimeInterval(-6*24*60*60)
            
            numDays = satPracticePlanningHelper(nDays: numDays, count: days.count, cDate: currentDate, tDate: tempDate)
        }
        if days.contains("Mon") {
            //gets the last Sunday before the selected sat date assuming all sats are on Saturdays. If College Board changes the day make sure to update it here
            let tempDate = endDate.addingTimeInterval(-5*24*60*60)
            
            numDays = satPracticePlanningHelper(nDays: numDays, count: days.count, cDate: currentDate, tDate: tempDate)
        }
        if days.contains("Tue") {
            //gets the last Sunday before the selected sat date assuming all sats are on Saturdays. If College Board changes the day make sure to update it here
            let tempDate = endDate.addingTimeInterval(-4*24*60*60)
            
            numDays = satPracticePlanningHelper(nDays: numDays, count: days.count, cDate: currentDate, tDate: tempDate)
        }
        if days.contains("Wed") {
            //gets the last Sunday before the selected sat date assuming all sats are on Saturdays. If College Board changes the day make sure to update it here
            let tempDate = endDate.addingTimeInterval(-3*24*60*60)
            
            numDays = satPracticePlanningHelper(nDays: numDays, count: days.count, cDate: currentDate, tDate: tempDate)
        }
        if days.contains("Thu") {
            //gets the last Sunday before the selected sat date assuming all sats are on Saturdays. If College Board changes the day make sure to update it here
            let tempDate = endDate.addingTimeInterval(-2*24*60*60)
            
            numDays = satPracticePlanningHelper(nDays: numDays, count: days.count, cDate: currentDate, tDate: tempDate)
        }
        if days.contains("Fri") {
            //gets the last Sunday before the selected sat date assuming all sats are on Saturdays. If College Board changes the day make sure to update it here
            let tempDate = endDate.addingTimeInterval(-8*24*60*60)
            
            numDays = satPracticePlanningHelper(nDays: numDays, count: days.count, cDate: currentDate, tDate: tempDate)
        }
        if days.contains("Sat") {
            //gets the last Sunday before the selected sat date assuming all sats are on Saturdays. If College Board changes the day make sure to update it here
            let tempDate = endDate.addingTimeInterval(-7*24*60*60)
            
            numDays = satPracticePlanningHelper(nDays: numDays, count: days.count, cDate: currentDate, tDate: tempDate)
        }
        
        
        print("ACT Planning success")
    }
    
    //test func to check contents of the Event array
    func printEventListContents () -> String{
        var string = ""
        
        for event in UserData.events {
            string = string + " | " + event.getName()
        }
        return string
    }
    
    //gets the event dates
    func getEventDates() -> [String]{
        
        var dateStrings = [String]()
        
        for event in UserData.events{
            dateStrings.append(event.getEventDate())
        }
        
        return dateStrings
    }
    
    //gets the event names
    func getEventNames() -> [String]{
        
        var nameStrings = [String]()
        
        for event in UserData.events{
            
            nameStrings.append(event.getName())
        }
        
        return nameStrings
    }
    
    //gets the events themselves
    func getEvents() -> [Event] {
        return UserData.events
    }
    
    //gets the dates for the sats
    func getSATDates() -> [String] {
        
        var satDates = [String]()
        
        for event in UserData.satEvents {
            satDates.append(event.getSATDate())
        }
        
        return satDates
    }
    
    //gets the dates for the acts
    func getACTDates() -> [String] {
        
        var actDates = [String]()
        
        for event in UserData.actEvents {
            actDates.append(event.getACTDate())
        }
        
        return actDates
    }
    
    
    //parses through a json to initialize data for the app (currently only initializes SAT information)
    func parseForDates(eventJsonData: Data, collegeJsonData: Data) {
        do {
            let decodedEventData = try EventData(data: eventJsonData)
            
            for d in decodedEventData.eventData.sat{
                addSATEvent(dID: d.id, rID: d.regID, date: d.saTdate!, reg: d.registration)
            }
            for d in decodedEventData.eventData.act{
                addACTEvent(dID: d.id, rID: d.regID, date: d.acTdate!, reg: d.registration)
            }
            
            print("event decode success")
        } catch {
            print("event decode error")
        }
        do {
            let decodedCollegeData = try CollegeData(data: collegeJsonData)
            
            for d in decodedCollegeData.collegeData.features {
                let c = College()
                c.initializeEvent(objectid: d.properties.objectid, ipedsid: d.properties.ipedsid, name: d.properties.name, address: d.properties.address, city: d.properties.city, state: d.properties.state, zip: d.properties.zip, zip4: d.properties.zip4, telephone: d.properties.telephone, type: d.properties.type, population: d.properties.population, county: d.properties.county, countyfips: d.properties.countyfips, country: d.properties.country, naicsCode: d.properties.naicsCode, naicsDesc: d.properties.naicsDesc, source: d.properties.source, website: d.properties.website, alias: d.properties.alias, ptEnroll: d.properties.ptEnroll, ftEnroll: d.properties.ftEnroll, totEnroll: d.properties.totEnroll, housing: d.properties.housing, dormCap: d.properties.dormCap, totEmp: d.properties.totEnroll, shelterID: d.properties.shelterID)
                UserData.colleges.append(c)
            }
            
            
            print("college decode success")
        }
        catch {
            print("college decode error")
        }
    }
    
    //reads a local json file and returns the necessary data as Data
    func readLocalJsonFile(forName name: String) -> Data? {
        do {
           if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print("Error while parsing: \(error)")
        }
        
        return nil
    }
    
    func removeEvent (eventName: String, eventDate: String) {
        var count = 0
        for s in UserData.events {
            if eventName == s.getName() && eventDate == s.getEventDate(){
                UserData.events.remove(at: count)
            }
        }
        count += 1
    }
    
    func removeSATEvents(){
        var count = 0
        for s in UserData.events{
            if s.getEventType() == "SAT"{
                UserData.events.remove(at: count)
            }
        }
        count += 1
    }
    
    func removeACTEvents(){
        var count = 0
        for s in UserData.events{
            if s.getEventType() == "ACT"{
                UserData.events.remove(at: count)
            }
        }
        count += 1
    }
}

extension String {
    func toDate(withFormat format: String = "yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else {
            print("fail")
            preconditionFailure("Take a look to your format")
            
    }
    return date
  }
}
