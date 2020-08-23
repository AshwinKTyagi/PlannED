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
    static var temporaryCollege = tempCollege(ipsed: "", name: "", alias: "")
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
    
    
    // MARK: TODO
    func calcReachCollege()
    {
        
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
        
        let college = NSManagedObject(entity: entity,
                                      insertInto: managedContext)
        
        self.ref.child("colleges").observeSingleEvent(of: .value, with: { (snapshot) in
            var i: Int = 0
            for child in snapshot.children  {
                let snap = child as! DataSnapshot
                let formatter = NumberFormatter()
                
                college.setValue(formatter.number(from: snap.key), forKey: "ipsed")
                college.setValue(snap.childSnapshot(forPath: "ACTCM25").value, forKey: "actcm25")
                college.setValue(snap.childSnapshot(forPath: "ACTCM75").value, forKey: "actcm75")
                college.setValue(snap.childSnapshot(forPath: "ACTCMMID").value, forKey: "actcmmid")
                college.setValue(snap.childSnapshot(forPath: "ACTEN25").value, forKey: "acten25")
                college.setValue(snap.childSnapshot(forPath: "ACTEN75").value, forKey: "acten75")
                college.setValue(snap.childSnapshot(forPath: "ACTENMID").value, forKey: "actenmid")
                college.setValue(snap.childSnapshot(forPath: "ACTMT25").value, forKey: "actmt25")
                college.setValue(snap.childSnapshot(forPath: "ACTMT75").value, forKey: "actmt75")
                college.setValue(snap.childSnapshot(forPath: "ACTMTMID").value, forKey: "actmtmid")
                college.setValue(snap.childSnapshot(forPath: "ACTWR25").value, forKey: "actwr25")
                college.setValue(snap.childSnapshot(forPath: "ACTWR75").value, forKey: "actwr75")
                college.setValue(snap.childSnapshot(forPath: "ACTWRMID").value, forKey: "actwrmid")
                college.setValue(snap.childSnapshot(forPath: "ADM_RATE").value, forKey: "admRate")
                college.setValue(snap.childSnapshot(forPath: "ADM_RATE_ALL").value, forKey: "admRateAll")
                college.setValue(snap.childSnapshot(forPath: "AGE_ENTRY").value, forKey: "ageEntry")
                college.setValue(snap.childSnapshot(forPath: "AGE_ENTRY_SQ").value, forKey: "ageEntrySq")
                college.setValue(snap.childSnapshot(forPath: "AGEGE24").value, forKey: "ageGe24")
                college.setValue(snap.childSnapshot(forPath: "ALIAS").value, forKey: "alias")
                college.setValue(snap.childSnapshot(forPath: "CITY").value, forKey: "city")
                college.setValue(snap.childSnapshot(forPath: "CURROPER").value, forKey: "cuurentlyOper")
                college.setValue(snap.childSnapshot(forPath: "DEPENDENT").value, forKey: "dependent")
                college.setValue(snap.childSnapshot(forPath: "FAMINC").value, forKey: "famIncome")
                college.setValue(snap.childSnapshot(forPath: "FAMINC_IND").value, forKey: "famIncomeInd")
                college.setValue(snap.childSnapshot(forPath: "FEMALE").value, forKey: "female")
                college.setValue(snap.childSnapshot(forPath: "FIRST_GEN").value, forKey: "firstGen")
                college.setValue(snap.childSnapshot(forPath: "GRADS").value, forKey: "grads")
                college.setValue(snap.childSnapshot(forPath: "HIGHDEG").value, forKey: "highDeg")
                college.setValue(snap.childSnapshot(forPath: "INSTNM").value, forKey: "instName")
                college.setValue(snap.childSnapshot(forPath: "INSTURL").value, forKey: "instWebsite")
                college.setValue(snap.childSnapshot(forPath: "MAIN").value, forKey: "main")
                college.setValue(snap.childSnapshot(forPath: "MARRIED").value, forKey: "married")
                college.setValue(snap.childSnapshot(forPath: "MENONLY").value, forKey: "menOnly")
                college.setValue(snap.childSnapshot(forPath: "NANTI").value, forKey: "nanti")
                college.setValue(snap.childSnapshot(forPath: "NPCURL").value, forKey: "netPriceCalcWebsite")
                college.setValue(snap.childSnapshot(forPath: "NUMBRANCH").value, forKey: "numBranch")
                college.setValue(snap.childSnapshot(forPath: "OPEID").value, forKey: "opeID")
                college.setValue(snap.childSnapshot(forPath: "OPEID6").value, forKey: "opeID6")
                college.setValue(snap.childSnapshot(forPath: "OPENADMP").value, forKey: "openadmp")
                college.setValue(snap.childSnapshot(forPath: "PBI").value, forKey: "pbi")
                college.setValue(snap.childSnapshot(forPath: "PCT_ASIAN").value, forKey: "pctAsian")
                college.setValue(snap.childSnapshot(forPath: "PCT_BA").value, forKey: "pctBA")
                college.setValue(snap.childSnapshot(forPath: "PCT_BLACK").value, forKey: "pctBlack")
                college.setValue(snap.childSnapshot(forPath: "PCT_BORN_US").value, forKey: "pctBornUS")
                college.setValue(snap.childSnapshot(forPath: "PCT_GRAD_PROF").value, forKey: "pctGradProf")
                college.setValue(snap.childSnapshot(forPath: "PCT_HISPANIC").value, forKey: "pctHispanic")
                college.setValue(snap.childSnapshot(forPath: "PCTPELL").value, forKey: "pctPell")
                college.setValue(snap.childSnapshot(forPath: "PCT_WHITE").value, forKey: "pctWhite")
                college.setValue(snap.childSnapshot(forPath: "POVERTY_RATE").value, forKey: "povertyRate")
                college.setValue(snap.childSnapshot(forPath: "PREDDEG").value, forKey: "predDeg")
                college.setValue(snap.childSnapshot(forPath: "RELAFFIL").value, forKey: "relAffiliation")
                college.setValue(snap.childSnapshot(forPath: "SAT_AVG").value, forKey: "satAvg")
                college.setValue(snap.childSnapshot(forPath: "SAT_AVG_ALL").value, forKey: "satAvgAll")
                college.setValue(snap.childSnapshot(forPath: "SATMT25").value, forKey: "satmt25")
                college.setValue(snap.childSnapshot(forPath: "SATMT75").value, forKey: "satmt75")
                college.setValue(snap.childSnapshot(forPath: "SATMTMID").value, forKey: "satmtmid")
                college.setValue(snap.childSnapshot(forPath: "SATVR25").value, forKey: "satvr25")
                college.setValue(snap.childSnapshot(forPath: "SATVR75").value, forKey: "satvr75")
                college.setValue(snap.childSnapshot(forPath: "SATVRMID").value, forKey: "satvrmid")
                college.setValue(snap.childSnapshot(forPath: "SATWR25").value, forKey: "satwr25")
                college.setValue(snap.childSnapshot(forPath: "SATWR75").value, forKey: "satwr75")
                college.setValue(snap.childSnapshot(forPath: "SATWRMID").value, forKey: "satwrmid")
                college.setValue(snap.childSnapshot(forPath: "SCH_DEG").value, forKey: "schDeg")
                college.setValue(snap.childSnapshot(forPath: "STABBR").value, forKey: "stateAbbr")
                college.setValue(snap.childSnapshot(forPath: "TRIBAL").value, forKey: "tribal")
                college.setValue(snap.childSnapshot(forPath: "TUITFTE").value, forKey: "tuitFTE")
                college.setValue(snap.childSnapshot(forPath: "TUITIONFEE_IN").value, forKey: "tuitionFeeIn")
                college.setValue(snap.childSnapshot(forPath: "TUITIONFEE_OUT").value, forKey: "tuitionFeeOut")
                college.setValue(snap.childSnapshot(forPath: "TUITIONFEE_PROG").value, forKey: "tuitionFeeProg")
                college.setValue(snap.childSnapshot(forPath: "UGNONDS").value, forKey: "ugnonds")
                college.setValue(snap.childSnapshot(forPath: "UNEMP_RATE").value, forKey: "unempRate")
                college.setValue(snap.childSnapshot(forPath: "VETERAN").value, forKey: "veteran")
                college.setValue(snap.childSnapshot(forPath: "WOMENONLY").value, forKey: "womenOnly")
                college.setValue(snap.childSnapshot(forPath: "ZIP").value, forKey: "zip")
                
                do {
                    try managedContext.save()
                    self.colleges.append(college)
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
                
                i += 1
            }
            print(i)
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        // 4
        do {
            try managedContext.save()
            colleges.append(college)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
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
