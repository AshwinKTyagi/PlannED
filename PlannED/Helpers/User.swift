//
//  User.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 7/22/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase

final class User: ObservableObject {
    
    static private var firstName = String()
    static private var lastName = String()
    static private var email = String()
    
    static private var takenSATs = [SAT]()
    static private var takenACTs = [ACT]()
    static private var chosenColleges = [tempCollege]()
    
    static private var eventDates = [tempEvent]()
    
    static private var ref = Database.database().reference()
    
    static private var helper = Helper()
    
    // MARK: setter functions
    static func setFirstName(firstName: String) {
        self.firstName = firstName
    }
        
    static func setLastName(lastName: String) {
        self.lastName = lastName
    }
    
    static func setEmail(email: String) {
        self.email = email
    }
    
    static func setTakenSATs(sats: [SAT]) {
        self.takenSATs = sats
    }
    
    static func setChosenCollegeChecklist(index: Int, checklistIndex: Int, value: Bool) {
        chosenColleges[index].checklist[checklistIndex] = value
        saveDataToFirebase()
    }
    
    static func setTakenSATs(sats: [Any]) {
        var tempSat = [SAT]()
        
        print("\(sats)")
        
        for s in sats{
            tempSat.append(SAT.init(dict: s as! NSDictionary))
        }
        
        self.takenSATs = tempSat
    }
    
    static func setTakenACTs(acts: [ACT]) {
        self.takenACTs = acts
    }
    
    static func setTakenACTs(acts: [Any]) {
        var tempAct = [ACT]()
        
        for a in acts{
            tempAct.append(ACT.init(dict: a as! NSDictionary))
        }
        
        self.takenACTs = tempAct
    }
    
    static func setChosenColleges(colleges: [tempCollege]) {
        self.chosenColleges = colleges
    }
    
    static func setChosenColleges(colleges: [Any]) {
        var tempColleges = [tempCollege]()
        
        for c in colleges{
            tempColleges.append(tempCollege.init(dict: c as! NSDictionary))
        }
        
        self.chosenColleges = tempColleges
    }
    
    static func setEventDates(events: [Any]) {
        var tempEvents = [tempEvent]()
        
        for e in events {
            tempEvents.append(tempEvent.init(dict: e as! NSDictionary))
            
            if tempEvents.last?.id == "SAT" {
                helper.addSATPlanning(days: tempEvents.last!.days, date: tempEvents.last!.date)
            }
            else if tempEvents.last?.id == "ACT" {
                helper.addACTPlanning(days: tempEvents.last!.days, date: tempEvents.last!.date)
            }
        }
        
        self.eventDates = tempEvents
    }
    
    // MARK: getter functions
    static func getFirstName() -> String {
        return firstName
    }
        
    static func getLastName() -> String {
        return lastName
    }
    
    static func getEmail() -> String {
        return email
    }
    
    static func getTakenSATs() -> [SAT] {
        return takenSATs
    }
    
    static func getTakenACTs() -> [ACT] {
        return takenACTs
    }
    
    static func getTakenSATsAsAnyObjects() -> [Any] {
        var sats = [Any]()
        
        for s in takenSATs{
            sats.append(s.toAnyObject())
        }
        
        return sats
    }
    
    static func getTakenACTsAsAnyObjects() -> [Any] {
        var acts = [Any]()
        
        for a in takenACTs{
            acts.append(a.toAnyObject())
        }
        
        return acts
    }
    
    static func getChosenColleges() -> [tempCollege] {
        return chosenColleges
    }
    
    static func getChosenCollegeNames() -> [String]{
        var names = [String]()
        
        for c in chosenColleges {
            names.append(c.name)
        }
        return names
    }
    
    static func getChosenCollegeIPSEDs() -> [String] {
        var ipseds = [String]()
        
        for c in chosenColleges {
            ipseds.append(c.ipsed)
        }
        return ipseds
    }
    
    static func getChosenCollegesAsAnyObjects() -> [Any] {
        var colleges = [Any]()
        
        for c in chosenColleges{
            colleges.append(c.toAnyObject())
        }
        
        return colleges
    }
    
    static func getEventDates() -> [tempEvent] {
        return eventDates
    }
    
    static func getEventDatesAsAnyObjects() -> [Any] {
        var dates = [Any]()
        
        for e in eventDates{
            dates.append(e.toAnyObject())
        }
        
        return dates
    }
    
    // MARK: add functions
    static func addTakenSAT(english: Int, math: Int, writing: Int, date: Date) {
        let sat = SAT.init(e: english, m: math, w: writing, d: date)
        takenSATs.append(sat)
        saveDataToFirebase()
    }
    
    static func addTakenACT(english: Double, reading: Double, math: Double, science: Double, writing: Double, date: Date) {
        let act = ACT.init(e: english, r: reading, m: math, s: science, w: writing, d: date)
        takenACTs.append(act)
        saveDataToFirebase()
    }
    
    static func addChosenCollege(college: tempCollege) {
        chosenColleges.append(college)
        saveDataToFirebase()
    }
    
    static func addEventDate(eventDate: String, eventType: String, days: [String]){
        eventDates.append(tempEvent.init(id: eventType, date: eventDate, days: days))
        saveDataToFirebase()
    }
    
    // MARK: remove functions
    static func removeTakenSAT(satIndex: Int) {
        takenSATs.remove(at: satIndex)
        saveDataToFirebase()
    }
    
    static func removeTakenACT(actIndex: Int) {
        takenACTs.remove(at: actIndex)
        saveDataToFirebase()
    }
    
    static func removeChosenCollege(collegeIndex: Int) {
        chosenColleges.remove(at: collegeIndex)
        saveDataToFirebase()
    }
    
    static func removeChosenCollege(college: tempCollege)
    {
        var i = Int()
        for c in chosenColleges{
            if c.ipsed == college.ipsed {
                chosenColleges.remove(at: i)
            }
            i += 1
        }
        saveDataToFirebase()
    }
    
    // MARK: saveDataToFireBase
    static func saveDataToFirebase() {
        let userData = ["firstName": User.getFirstName(),
                        "lastName": User.getLastName(),
                        "email": User.getEmail(),
                        "takenSATs": User.getTakenSATsAsAnyObjects(),
                        "takenACTs": User.getTakenACTsAsAnyObjects(),
                        "chosenColleges": User.getChosenCollegesAsAnyObjects(),
                        "finalEventDates": User.getEventDatesAsAnyObjects()
            ] as [String : Any]
        
        self.ref.child("users").child((Auth.auth().currentUser?.uid)!).setValue(userData)
    }

    // MARK: collegePlan
    static func collegePlan() {
        
    }
    
    // MARK: collegePlan(appDate: String)
    static func collegePlan(appDate: String) {
        
    }
    
    // MARK: collegePlan(appDate: String)
    static func collegePlan(appDate: Date) {
        
    }
    
}

// MARK: SAT struct
struct SAT {
    var english: Int
    var math: Int
    var writing: Int
    var total: Int
    var date: Date
    
    init(e: Int, m: Int, w: Int, d: Date) {
        self.english = e
        self.math = m
        self.writing = w
        self.date = d
        self.total = e + m
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        english = snapshotValue["english"] as! Int
        math = snapshotValue["math"] as! Int
        writing = snapshotValue["writing"] as! Int
        date = (snapshotValue["date"] as! NSDate) as Date
        total = snapshotValue["total"] as! Int
    }
    
    init(dict: NSDictionary) {
        english = dict["english"] as! Int
        math = dict["math"] as! Int
        writing = dict["writing"] as! Int
        total = dict["total"] as! Int
        
        let d = dict["date"] as! String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        date = dateFormatter.date(from: d)!
    }
    // function for saving data
    func toAnyObject() -> Any {
        return [
            "english": english,
            "math": math,
            "writing": writing,
            "date": "\(date)",
            "total": total
        ]
     }
}

// MARK: ACT struct
struct ACT {
    var english: Double
    var reading: Double
    var math   : Double
    var science: Double
    var writing: Double
    var date: Date
    var total: Int
    
    init(e: Double, r: Double, m: Double, s: Double, w: Double, d: Date) {
        self.english = e
        self.reading = r
        self.math = m
        self.science = s
        self.date = d
        self.writing = w
        
        if self.writing == 0 {
            let t = ((e + r + m + s) / 4)
            self.total = Int(t.rounded())
        }
        else {
            let t = ((e + r + m + s + w) / 5)
            self.total = Int(t.rounded())
        }
        
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        english = snapshotValue["english"] as! Double
        reading = snapshotValue["reading"] as! Double
        math = snapshotValue["math"] as! Double
        science = snapshotValue["reading"] as! Double
        writing = snapshotValue["writing"] as! Double
        date = (snapshotValue["date"] as! NSDate) as Date
        total = snapshotValue["total"] as! Int
    }
    
    init(dict: NSDictionary){
        english = dict["english"] as! Double
        reading = dict["reading"] as! Double
        math = dict["math"] as! Double
        science = dict["reading"] as! Double
        writing = dict["writing"] as! Double
        date = (dict["date"] as! NSDate) as Date
        total = dict["total"] as! Int
    }
    
    // function for saving data
    func toAnyObject() -> Any {
        return [
            "english": english,
            "reading": reading,
            "math": math,
            "science": science,
            "writing": writing,
            "date": "\(date)",
            "total": total
        ]
     }
}

// MARK: tempCollege struct
struct tempCollege {
    let ipsed: String
    let name: String
    let alias: String
    var reach: Int
    var checklist: [Bool]
    
    init(ipsed: String, name: String, alias: String, reach: Int, checklist: [Bool]) {
        self.ipsed = ipsed
        self.name = name
        self.alias = alias
        self.reach = reach
        self.checklist = checklist
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        ipsed = snapshotValue["ipsed"] as! String
        name = snapshotValue["name"] as! String
        alias = snapshotValue["alias"] as! String
        reach = snapshotValue["reach"] as! Int
        checklist = snapshotValue["checklist"] as! [Bool]
    }
    
    init(dict: NSDictionary){
        ipsed = dict["ipsed"] as! String
        name = dict["name"] as! String
        alias = dict["alias"] as! String
        reach = dict["reach"] as! Int
        checklist = dict["checklist"] as! [Bool]
    }
    
    func toAnyObject() -> Any {
        return [
            "ipsed": ipsed,
            "name": name,
            "alias": alias,
            "reach": reach,
            "checklist": checklist
        ]
    }
}

// MARK: Event struct
struct Event {
    
    var id: String
    var name: String
    var description: String
    var date: String
    
    static var idList = ["Normal", "SAT", "ACT", "College"]
    
    init(id: String, n: String, desc: String, date: String) {
        self.id = id
        self.name = n
        self.description = desc
        self.date = date
    }
    
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        id = snapshotValue["id"] as! String
        name = snapshotValue["name"] as! String
        description = snapshotValue["description"] as! String
        date = snapshotValue["date"] as! String
    }
    
    init(dict: NSDictionary){
        id = dict["id"] as! String
        name = dict["name"] as! String
        description = dict["description"] as! String
        date = dict["date"] as! String
    }
    
    // function for saving data
    func toAnyObject() -> Any {
        return [
            "id": id,
            "name": name,
            "description": description,
            "date": date
        ]
     }

}

// MARK: tempEvent
struct tempEvent {
    var id: String
    var date: String
    var days: [String]
    
    static var idList = ["Normal", "SAT", "ACT", "College"]
    
    init(id: String, date: String, days: [String]) {
        self.id = id
        self.date = date
        self.days = days
    }
    
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        id = snapshotValue["id"] as! String
        date = snapshotValue["date"] as! String
        days = snapshotValue["days"] as! [String]
    }
    
    init(dict: NSDictionary){
        id = dict["id"] as! String
        date = dict["date"] as! String
        days = dict["days"] as! [String]
    }
    
    // function for saving data
    func toAnyObject() -> Any {
        return [
            "id": id,
            "date": date,
            "days": days
        ]
     }

}
