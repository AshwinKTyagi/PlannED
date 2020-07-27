//
//  User.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 7/22/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//

import SwiftUI
import FirebaseDatabase

final class User: ObservableObject {
    
    static private var firstName = String()
    static private var lastName = String()
    static private var email = String()
    
    static private var takenSATs = [SAT]()
    static private var takenACTs = [ACT]()
    static private var chosenColleges = [College]()
    
    static func setFirstName(firstName: String) {
        self.firstName = firstName
    }
        
    static func setLastName(lastName: String) {
        self.lastName = lastName
    }
    
    static func setEmail(email: String) {
        self.email = email
    }
    
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
    
    static func getChosenColleges() -> [College] {
        return chosenColleges
    }
    
    static func addTakenSAT(english: Int, math: Int, writing: Int, date: Date) {
        let sat = SAT.init(e: english, m: math, w: writing, d: date)
        takenSATs.append(sat)
    }
    
    static func addTakenACT(english: Double, reading: Double, math: Double, science: Double, writing: Double, date: Date) {
        let act = ACT.init(e: english, r: reading, m: math, s: science, w: writing, d: date)
        takenACTs.append(act)
    }
    
    static func removeTakenSAT(satIndex: Int) {
        takenSATs.remove(at: satIndex)
    }
    
    static func removeTakenACT(actIndex: Int) {
        takenACTs.remove(at: actIndex)
    }
    
}

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
}

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
}
