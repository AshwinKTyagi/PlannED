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
    
    static func addTakenSAT(english: Int, math: Int, writing: Int) {
        let sat = SAT.init(e: english, m: math, w: writing)
        takenSATs.append(sat)
    }
    
    static func addTakenACTs(english: Int, reading: Int, math: Int, science: Int, writing: Int) {
        let act = ACT.init(e: english, r: reading, m: math, s: science, w: writing)
        takenACTs.append(act)
    }
    
    
}

struct SAT {
    var english: Int
    var math: Int
    var writing: Int
    var total: Int
    
    init(e: Int, m: Int, w: Int) {
        self.english = e
        self.math = m
        self.writing = w
        self.total = e + m
    }
}

struct ACT {
    var english: Int
    var reading: Int
    var math: Int
    var science: Int
    var writing: Int
    var total: Int
    
    init(e: Int, r: Int, m: Int, s: Int, w: Int) {
        self.english = e
        self.reading = r
        self.math = m
        self.science = s
        self.writing = w
        self.total = e + r + m + s
        
    }
}
