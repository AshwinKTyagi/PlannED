//
//  Helper.swift
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
import CoreData
import FirebaseDatabase

final class Helper: ObservableObject {
    
    private static var events = [Event]()
    private static var satEvents = [SATEvent]()
    private static var actEvents = [ACTEvent]()
    static var temporaryCollege = tempCollege(ipsed: "", name: "", alias: "", reach: -1, checklist: [false, false, false, false, false, false])
    static var collegeNameData = [String]()
    static var collegeData = [tempCollege]()

    static var colleges: [NSManagedObject] = []
    
    static let ref = Database.database().reference()
    
    //generic addEvent method that accepts date as a Date and formats it into a String
    // MARK: addEvent with Date
    func addEvent(eventType: String, name: String, desc: String, date: Date) {
        
        let event = Event()
        
        let d = date
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let string = formatter.string(from: d)
        
        event.initializeEvent(eventType: eventType, eventName: name, eventDescription: desc, eventDate: string)
        
        Helper.events.append(event)
        
    }
    
    //generic addEvent method that accepts date as a String
    // MARK: addEvent with String
    func addEvent(eventType: String, name: String, desc: String, date: String) {
        
        let event = Event()
        
        event.initializeEvent(eventType: eventType, eventName: name, eventDescription: desc, eventDate: date)
        
        Helper.events.append(event)
        
    }
    
    //adds a SAT Event
    // MARK: addSATEvent
    func addSATEvent(dID: String, rID: String, date: String, reg: String) {
        
        let event = SATEvent()
        
        event.initializeEvent(dID: dID, rID: rID, satDate: date, registration: reg)
        
        Helper.satEvents.append(event)
        
    }
    
    //adds an ACT Event
    // MARK: addACTEvent
    func addACTEvent(dID: String, rID: String, date: String, reg: String) {
        
        let event = ACTEvent()
        
        event.initializeEvent(dID: dID, rID: rID, actDate: date, registration: reg)
        
        Helper.actEvents.append(event)
        
    }
    
    // creates the actual events for sat
    // MARK: satPracticePlanningHelper
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
    
    // creates the actual events for acts
    // MARK: actPracticePlanningHelper
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
    
    
    //sets up Planning for ACT using selected weekdays and a test date
    // MARK: addACTPlanning
    func addACTPlanning(days: [String], date: String) {
        
        var actDateID = String()
        var actRegID = String()
        var actRegistration = String()
        
        //adds events for actual SAT and Registration
        for a in Helper.actEvents {
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
    
    //sets up Planning for SAT using selected weekdats and a test date
    // MARK: addSATPlanning
    func addSATPlanning(days: [String], date: String) {
        
        var satDateID = String()
        var satRegID = String()
        var satRegistration = String()
        
        //adds events for actual SAT and Registration
        for s in Helper.satEvents {
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
    // MARK: printEventListContents
    func printEventListContents () -> String{
        var string = ""
        
        for event in Helper.events {
            string = string + " | " + event.getName()
        }
        return string
    }
    
    // MARK: changeTempCollege
    static func changeTempCollege(college: tempCollege) {
        temporaryCollege = college
    }
    
    
    //gets the event dates
    // MARK: getEventDates
    func getEventDates() -> [String]{
        
        var dateStrings = [String]()
        
        for event in Helper.events{
            dateStrings.append(event.getEventDate())
        }
        
        return dateStrings
    }
    
    //gets the event names
    // MARK: getEventNames
    func getEventNames() -> [String]{
        
        var nameStrings = [String]()
        
        for event in Helper.events{
            
            nameStrings.append(event.getName())
        }
        
        return nameStrings
    }
    
    //gets the events themselves
    // MARK: getEvents
    func getEvents() -> [Event] {
        return Helper.events
    }
    
    //gets the dates for the sats
    // MARK: getSATDates
    func getSATDates() -> [String] {
        
        var satDates = [String]()
        
        for event in Helper.satEvents {
            satDates.append(event.getSATDate())
        }
        
        return satDates
    }
    
    //gets the dates for the acts
    // MARK: getACTDates
    func getACTDates() -> [String] {
        
        var actDates = [String]()
        
        for event in Helper.actEvents {
            actDates.append(event.getACTDate())
        }
        
        return actDates
    }
    
    // MARK: getColleges
    func getColleges() -> [tempCollege] {
        return Helper.collegeData
    }
    
    // MARK: getCollegeNames
    func getCollegeNames() -> [String] {
        
        return Helper.collegeNameData
    }
    
    //parses through a json to initialize data for the app (currently only initializes SAT information)
    // MARK: parseForDates
    func parseForDates(eventJsonData: Data) {
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
    }
        
    //reads a local json file and returns the necessary data as Data
    // MARK: readLocalJsonFile
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
    
    //removes one Specific Event
    // MARK: removeEvent
    func removeEvent (eventName: String, eventDate: String) {
        var count = 0
        for s in Helper.events {
            if eventName == s.getName() && eventDate == s.getEventDate(){
                Helper.events.remove(at: count)
            }
        }
        count += 1
    }
    
    //removes all the SAT events for a single test date
    // MARK: removeSATEvents
    func removeSATEvents(){
        var count = 0
        for s in Helper.events{
            if s.getEventType() == "SAT"{
                Helper.events.remove(at: count)
            }
        }
        count += 1
    }
    
    // removes all the ACT events for a single test date
    // MARK: removeACTEvents
    func removeACTEvents(){
        var count = 0
        for s in Helper.events{
            if s.getEventType() == "ACT"{
                Helper.events.remove(at: count)
            }
        }
        count += 1
    }
    
    // returns 0 for safety, 1 for target, 2 for reach
    // MARK: calcReachSat(sat25, sat75)
    static func calcReachSAT(sat25: Int, sat75: Int) -> Int
    {
        if sat25 == -1 || sat75 == -1 {
            return -1
        }
        
        var highestSat = Int()
        for s in User.getTakenSATs() {
            if s.total > highestSat {
                highestSat = s.total
            }
        }
        
        if highestSat == 0 {
            return -1
        }
        
        if highestSat > sat75 + 20 {
            return 0
        }
        else if highestSat > sat25 {
            return 1
        }
        else {
            return 2
        }
    }
    
    // returns 0 for safety, 1 for target, 2 for reach
    // MARK: calcReachSat(satmid)
    static func calcReachSAT(satmid: Int) -> Int
    {
        if satmid == -1 {
            return -1
        }
        var highestSat = Int()
        for s in User.getTakenSATs() {
            if s.total > highestSat {
                highestSat = s.total
            }
        }
        
        if highestSat == 0 {
            return -1
        }
        
        if highestSat > satmid + 50 {
            return 0
        }
        else if highestSat > satmid - 20 {
            return 1
        }
        else {
            return 2
        }
    }
    
    // returns 0 for safety, 1 for target, 2 for reach
    // MARK: calcReachAct(act25, act75)
    static func calcReachACT(act25: Int, act75: Int) -> Int
    {
        if act25 == -1 || act75 == -1 {
            return -1
        }
        
        var highestAct = Int()
        for a in User.getTakenACTs() {
            if a.total > highestAct {
                highestAct = a.total
            }
        }
        
        if highestAct == 0 {
            return -1
        }
        
        if highestAct > act75 + 2 {
            return 0
        }
        else if highestAct > act25 {
            return 1
        }
        else {
            return 2
        }
    }
    
    // returns 0 for safety, 1 for target, 2 for reach
    // MARK: calcReachAct(actmid)
    static func calcReachACT(actmid: Int) -> Int
    {
        if actmid == -1 {
            return -1
        }
        var highestAct = Int()
        for a in User.getTakenACTs() {
            if a.total > highestAct {
                highestAct = a.total
            }
        }
        
        if highestAct == 0 {
            return -1
        }
        
        if highestAct > actmid + 5 {
            return 0
        }
        else if highestAct > actmid - 2 {
            return 1
        }
        else {
            return 2
        }
    }
    
    
    // MARK: saveCollegesToCoreData
    static func saveCollegeToCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // 1
         let managedContext = appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "College",
                                       in: managedContext)!
        
        self.ref.child("colleges").observeSingleEvent(of: .value, with: { (snapshot) in
            var i: Int = 0
            for child in snapshot.children  {
                let snap = child as! DataSnapshot                
                let formatter = NumberFormatter()
                
                let college = NSManagedObject(entity: entity, insertInto: managedContext)
                
                let ipsed: Int = formatter.number(from: snap.key) as! Int
                let instName = snap.childSnapshot(forPath: "INSTNM").value as? String ?? ""
                let alias = snap.childSnapshot(forPath: "ALIAS").value as? String ?? ""
                
                
                
                college.setValue(ipsed, forKey: "ipsed")
                college.setValue(instName, forKey: "instName")
                college.setValue(alias, forKey: "alias")

                
                self.colleges.append(college)
                
                i += 1
            }
            print(i)
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }

}

// MARK: STRING EXTENSION
extension String {
    
    // formats a date from String to date
    // MARK: toDate
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
