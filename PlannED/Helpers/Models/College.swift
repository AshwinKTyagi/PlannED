//
//  CollegeEvent.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 7/10/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//
import SwiftUI

final class College: ObservableObject {
    
    private var objectid = Int()
    private var ipedsid = String()
    private var name = String()
    private var address  = String()
    private var city  = String()
    private var state =  String()
    private var zip = String()
    private var zip4 = String()
    private var telephone = String()
    private var type = String()
    private var status =  String()
    private var population = Int()
    private var county = String()
    private var countyfips = String()
    private var country =  String()
    private var naicsCode = String()
    private var naicsDesc =  String()
    private var source = String()
    private var website = String()
    private var alias = String()
    private var ptEnroll = Int()
    private var ftEnroll = Int()
    private var totEnroll = Int()
    private var housing =  String()
    private var dormCap = Int()
    private var totEmp = Int()
    private var shelterID =  String()
    
    private var applicationDate = String()
    private var averageSat = Int()
    private var averageAct = Int()
    
    //MARK: intializeEvent
    func initializeEvent(objectid: Int, ipedsid: String, name: String, address: String, city: String, state: String, zip: String, zip4: String, telephone: String, type: String, population: Int, county: String, countyfips: String, country: String, naicsCode: String, naicsDesc: String, source: String, website: String, alias: String, ptEnroll: Int, ftEnroll: Int, totEnroll: Int, housing: String, dormCap: Int, totEmp: Int, shelterID: String) {
        self.objectid = objectid
        self.ipedsid = ipedsid
        self.name = name
        self.address = address
        self.city = city
        self.state = state
        self.zip = zip
        self.zip4 = zip4
        self.telephone = telephone
        self.type = type
        self.status = state
        self.population = population
        self.county = county
        self.countyfips = countyfips
        self.country = country
        self.naicsCode = naicsCode
        self.naicsDesc = naicsDesc
        self.source = source
        self.website = website
        self.alias = alias
        self.ptEnroll = ptEnroll
        self.ftEnroll = ftEnroll
        self.totEnroll = totEnroll
        self.housing = housing
        self.dormCap = dormCap
        self.totEmp = totEmp
        self.shelterID = shelterID
        
    }
    
    //MARK: initializeApplicationDate
    func initializeApplicationDate(applicationDate: String) {
        self.applicationDate = applicationDate
    }
    
    
    // MARK: getter methods
    func getObjectID() -> Int{
        return objectid
    }
    
    func getIpedsID() -> String{
        return ipedsid
    }
    
    func getName() -> String{
        return name
    }
    
    func getAddress() -> String{
        return address
    }
    
    func getCity() -> String{
        return city
    }
    
    func getState() -> String{
        return state
    }
    
    func getZip() -> String{
        return zip
    }
    
    func getZip4() -> String{
        return zip4
    }
    
    func getTelephone() -> String{
        return telephone
    }
    
    func getType() -> String{
        return type
    }
    
    func getStatus() -> String{
        return status
    }
    
    func getPopulation() -> Int{
        return population
    }
    
    func getCounty() -> String{
        return county
    }
    
    func getCountyFips() -> String{
        return countyfips
    }
    
    func getCountry() -> String{
        return country
    }
    
    func getNaicsCode() -> String{
        return naicsCode
    }
    
    func getNaicsDesc() -> String{
        return naicsDesc
    }
    
    func getSource() -> String{
        return source
    }
    
    func getWebsite() -> String{
        return website
    }
    
    func getAlias() -> String{
        return alias
    }
    
    func getPartTimeEnroll() -> Int{
        return ptEnroll
    }
    
    func getFullTimeEnroll() -> Int{
        return ftEnroll
    }
    
    func getTotalEnroll() -> Int{
        return totEnroll
    }
    
    func getHousing() -> String{
        return housing
    }
    
    func getDormCap() -> Int{
        return dormCap
    }
    
    func getTotalEmp() -> Int{
        return totEmp
    }
    
    func getShelterID() -> String{
        return shelterID
    }
    
    func getAverageSat() -> Int {
        return averageSat
    }
    
    func getAverageAct() -> Int {
        return averageAct
    }
}
