//
//  SATDates.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 7/4/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//

import SwiftUI
import CoreLocation
import Foundation

// MARK: - EventData
struct EventData: Codable {
    let eventData: EventDataClass

    enum CodingKeys: String, CodingKey {
        case eventData = "EventData"
    }
}

// MARK: EventData convenience initializers and mutators

extension EventData {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(EventData.self, from: data)
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
        eventData: EventDataClass? = nil
    ) -> EventData {
        return EventData(
            eventData: eventData ?? self.eventData
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - EventDataClass
struct EventDataClass: Codable {
    let sat, act: [Act]

    enum CodingKeys: String, CodingKey {
        case sat = "SAT"
        case act = "ACT"
    }
}

// MARK: EventDataClass convenience initializers and mutators

extension EventDataClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(EventDataClass.self, from: data)
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
        sat: [Act]? = nil,
        act: [Act]? = nil
    ) -> EventDataClass {
        return EventDataClass(
            sat: sat ?? self.sat,
            act: act ?? self.act
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Act
struct Act: Codable {
    let id, regID: String
    let acTdate: String?
    let registration: String
    let saTdate: String?

    enum CodingKeys: String, CodingKey {
        case id, regID
        case acTdate = "ACTdate"
        case registration
        case saTdate = "SATdate"
    }
}

// MARK: Act convenience initializers and mutators

extension Act {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Act.self, from: data)
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
        id: String? = nil,
        regID: String? = nil,
        acTdate: String?? = nil,
        registration: String? = nil,
        saTdate: String?? = nil
    ) -> Act {
        return Act(
            id: id ?? self.id,
            regID: regID ?? self.regID,
            acTdate: acTdate ?? self.acTdate,
            registration: registration ?? self.registration,
            saTdate: saTdate ?? self.saTdate
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}


