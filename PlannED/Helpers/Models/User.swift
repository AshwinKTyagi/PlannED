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
    static private var chosenColleges = [String]() //saved as colleges ipsed
    
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
    
    static func setTakenSATs(sats: [Any]) {
        var tempSat = [SAT]()
        
        for s in sats{
            tempSat.append(SAT.init(snapshot: s as! DataSnapshot))
        }
        
        self.takenSATs = tempSat
    }
    
    static func setTakenACTs(acts: [ACT]) {
        self.takenACTs = acts
    }
    
    static func setTakenACTs(acts: [Any]) {
        var tempAct = [ACT]()
        
        for a in acts{
            tempAct.append(ACT.init(snapshot: a as! DataSnapshot))
        }
        
        self.takenACTs = tempAct
    }
    
    static func setChosenColleges(collegeIPEDSIDs: [String]) {
        self.chosenColleges = collegeIPEDSIDs
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
    
    static func getChosenColleges() -> [String] {
        return chosenColleges
    }
    
    // MARK: add functions
    static func addTakenSAT(english: Int, math: Int, writing: Int, date: Date) {
        let sat = SAT.init(e: english, m: math, w: writing, d: date)
        takenSATs.append(sat)
        
        self.ref.child("users").child((Auth.auth().currentUser?.uid)!).setValue(["takenSATs": getTakenSATsAsAnyObjects()])
    }
    
    static func addTakenACT(english: Double, reading: Double, math: Double, science: Double, writing: Double, date: Date) {
        let act = ACT.init(e: english, r: reading, m: math, s: science, w: writing, d: date)
        takenACTs.append(act)
        
        self.ref.child("users").child((Auth.auth().currentUser?.uid)!).setValue(["takenACTs": getTakenACTsAsAnyObjects()])
    }
    
    // MARK: remove functions
    static func removeTakenSAT(satIndex: Int) {
        takenSATs.remove(at: satIndex)
        self.ref.child("users").child((Auth.auth().currentUser?.uid)!).setValue(["takenSATs": getTakenSATsAsAnyObjects()])
    }
    
    static func removeTakenACT(actIndex: Int) {
        takenACTs.remove(at: actIndex)
        self.ref.child("users").child((Auth.auth().currentUser?.uid)!).setValue(["takenACTs": getTakenACTsAsAnyObjects()])
    }
    
    static func saveDataToFirebase() {
        let userData = ["firstName": User.getFirstName(),
                        "lastName": User.getLastName(),
                        "takenSATs": User.getTakenSATsAsAnyObjects(),
                        "takenACTs": User.getTakenACTsAsAnyObjects(),
                        "chosenColleges": User.getChosenColleges()
            ] as [String : Any]
        
        self.ref.child("users").child((Auth.auth().currentUser?.uid)!).setValue(userData)
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

    // function for saving data
    func toAnyObject() -> Any {
        return [
            "english": english,
            "math": math,
            "writing": writing,
            "date": date,
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

    // function for saving data
    func toAnyObject() -> Any {
        return [
            "english": english,
            "reading": reading,
            "math": math,
            "science": science,
            "writing": writing,
            "date": date,
            "total": total
        ]
     }
}
