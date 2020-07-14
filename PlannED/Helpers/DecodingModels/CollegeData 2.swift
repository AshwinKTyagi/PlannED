//
//  College.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 7/9/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//


import SwiftUI
import CoreLocation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let collegeData = try CollegeData(json)

import Foundation

// MARK: - CollegeData
struct CollegeData: Codable {
    let collegeData: CollegeDataClass

    enum CodingKeys: String, CodingKey {
        case collegeData = "CollegeData"
    }
}

// MARK: CollegeData convenience initializers and mutators

extension CollegeData {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CollegeData.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        collegeData: CollegeDataClass? = nil
    ) -> CollegeData {
        return CollegeData(
            collegeData: collegeData ?? self.collegeData
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - CollegeDataClass
struct CollegeDataClass: Codable {
    let type, name: String
    let crs: CRS
    let features: [Feature]
}

// MARK: CollegeDataClass convenience initializers and mutators

extension CollegeDataClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CollegeDataClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        type: String? = nil,
        name: String? = nil,
        crs: CRS? = nil,
        features: [Feature]? = nil
    ) -> CollegeDataClass {
        return CollegeDataClass(
            type: type ?? self.type,
            name: name ?? self.name,
            crs: crs ?? self.crs,
            features: features ?? self.features
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - CRS
struct CRS: Codable {
    let type: String
    let properties: CRSProperties
}

// MARK: CRS convenience initializers and mutators

extension CRS {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CRS.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        type: String? = nil,
        properties: CRSProperties? = nil
    ) -> CRS {
        return CRS(
            type: type ?? self.type,
            properties: properties ?? self.properties
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - CRSProperties
struct CRSProperties: Codable {
    let name: String
}

// MARK: CRSProperties convenience initializers and mutators

extension CRSProperties {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CRSProperties.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        name: String? = nil
    ) -> CRSProperties {
        return CRSProperties(
            name: name ?? self.name
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Feature
struct Feature: Codable {
    let type: FeatureType
    let properties: FeatureProperties
    let geometry: Geometry
}

// MARK: Feature convenience initializers and mutators

extension Feature {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Feature.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        type: FeatureType? = nil,
        properties: FeatureProperties? = nil,
        geometry: Geometry? = nil
    ) -> Feature {
        return Feature(
            type: type ?? self.type,
            properties: properties ?? self.properties,
            geometry: geometry ?? self.geometry
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Geometry
struct Geometry: Codable {
    let type: GeometryType
    let coordinates: [Double]
}

// MARK: Geometry convenience initializers and mutators

extension Geometry {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Geometry.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        type: GeometryType? = nil,
        coordinates: [Double]? = nil
    ) -> Geometry {
        return Geometry(
            type: type ?? self.type,
            coordinates: coordinates ?? self.coordinates
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum GeometryType: String, Codable {
    case point = "Point"
}

// MARK: - FeatureProperties
struct FeatureProperties: Codable {
    let objectid: Int
    let ipedsid, name, address, city: String
    let state: String
    let zip, zip4, telephone, type: String
    let status: String
    let population: Int
    let county, countyfips: String
    let country: String
    let latitude, longitude: Double
    let naicsCode: String
    let naicsDesc: String
    let source: String
    let sourcedate: Int
    let valMethod: String
    let valDate: Int
    let website: String
    let stfips, cofips, sector, level: String
    let hiOffer, degGrant, locale, closeDate: String
    let mergeID, alias, sizeSet, instSize: String
    let ptEnroll, ftEnroll, totEnroll: Int
    let housing: String
    let dormCap, totEmp: Int
    let shelterID: String

    enum CodingKeys: String, CodingKey {
        case objectid = "OBJECTID"
        case ipedsid = "IPEDSID"
        case name = "NAME"
        case address = "ADDRESS"
        case city = "CITY"
        case state = "STATE"
        case zip = "ZIP"
        case zip4 = "ZIP4"
        case telephone = "TELEPHONE"
        case type = "TYPE"
        case status = "STATUS"
        case population = "POPULATION"
        case county = "COUNTY"
        case countyfips = "COUNTYFIPS"
        case country = "COUNTRY"
        case latitude = "LATITUDE"
        case longitude = "LONGITUDE"
        case naicsCode = "NAICS_CODE"
        case naicsDesc = "NAICS_DESC"
        case source = "SOURCE"
        case sourcedate = "SOURCEDATE"
        case valMethod = "VAL_METHOD"
        case valDate = "VAL_DATE"
        case website = "WEBSITE"
        case stfips = "STFIPS"
        case cofips = "COFIPS"
        case sector = "SECTOR"
        case level = "LEVEL_"
        case hiOffer = "HI_OFFER"
        case degGrant = "DEG_GRANT"
        case locale = "LOCALE"
        case closeDate = "CLOSE_DATE"
        case mergeID = "MERGE_ID"
        case alias = "ALIAS"
        case sizeSet = "SIZE_SET"
        case instSize = "INST_SIZE"
        case ptEnroll = "PT_ENROLL"
        case ftEnroll = "FT_ENROLL"
        case totEnroll = "TOT_ENROLL"
        case housing = "HOUSING"
        case dormCap = "DORM_CAP"
        case totEmp = "TOT_EMP"
        case shelterID = "SHELTER_ID"
    }
}

// MARK: FeatureProperties convenience initializers and mutators

extension FeatureProperties {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(FeatureProperties.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        objectid: Int? = nil,
        ipedsid: String? = nil,
        name: String? = nil,
        address: String? = nil,
        city: String? = nil,
        state: String? = nil,
        zip: String? = nil,
        zip4: String? = nil,
        telephone: String? = nil,
        type: String? = nil,
        status: String? = nil,
        population: Int? = nil,
        county: String? = nil,
        countyfips: String? = nil,
        country: String? = nil,
        latitude: Double? = nil,
        longitude: Double? = nil,
        naicsCode: String? = nil,
        naicsDesc: String? = nil,
        source: String? = nil,
        sourcedate: Int? = nil,
        valMethod: String? = nil,
        valDate: Int? = nil,
        website: String? = nil,
        stfips: String? = nil,
        cofips: String? = nil,
        sector: String? = nil,
        level: String? = nil,
        hiOffer: String? = nil,
        degGrant: String? = nil,
        locale: String? = nil,
        closeDate: String? = nil,
        mergeID: String? = nil,
        alias: String? = nil,
        sizeSet: String? = nil,
        instSize: String? = nil,
        ptEnroll: Int? = nil,
        ftEnroll: Int? = nil,
        totEnroll: Int? = nil,
        housing: String? = nil,
        dormCap: Int? = nil,
        totEmp: Int? = nil,
        shelterID: String? = nil
    ) -> FeatureProperties {
        return FeatureProperties(
            objectid: objectid ?? self.objectid,
            ipedsid: ipedsid ?? self.ipedsid,
            name: name ?? self.name,
            address: address ?? self.address,
            city: city ?? self.city,
            state: state ?? self.state,
            zip: zip ?? self.zip,
            zip4: zip4 ?? self.zip4,
            telephone: telephone ?? self.telephone,
            type: type ?? self.type,
            status: status ?? self.status,
            population: population ?? self.population,
            county: county ?? self.county,
            countyfips: countyfips ?? self.countyfips,
            country: country ?? self.country,
            latitude: latitude ?? self.latitude,
            longitude: longitude ?? self.longitude,
            naicsCode: naicsCode ?? self.naicsCode,
            naicsDesc: naicsDesc ?? self.naicsDesc,
            source: source ?? self.source,
            sourcedate: sourcedate ?? self.sourcedate,
            valMethod: valMethod ?? self.valMethod,
            valDate: valDate ?? self.valDate,
            website: website ?? self.website,
            stfips: stfips ?? self.stfips,
            cofips: cofips ?? self.cofips,
            sector: sector ?? self.sector,
            level: level ?? self.level,
            hiOffer: hiOffer ?? self.hiOffer,
            degGrant: degGrant ?? self.degGrant,
            locale: locale ?? self.locale,
            closeDate: closeDate ?? self.closeDate,
            mergeID: mergeID ?? self.mergeID,
            alias: alias ?? self.alias,
            sizeSet: sizeSet ?? self.sizeSet,
            instSize: instSize ?? self.instSize,
            ptEnroll: ptEnroll ?? self.ptEnroll,
            ftEnroll: ftEnroll ?? self.ftEnroll,
            totEnroll: totEnroll ?? self.totEnroll,
            housing: housing ?? self.housing,
            dormCap: dormCap ?? self.dormCap,
            totEmp: totEmp ?? self.totEmp,
            shelterID: shelterID ?? self.shelterID
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum FeatureType: String, Codable {
    case feature = "Feature"
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
