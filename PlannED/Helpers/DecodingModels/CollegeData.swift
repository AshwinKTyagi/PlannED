//
//  College.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 7/9/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//
import Foundation



// MARK: - CollegeData
struct CollegeData: Codable {
    let colleges: [College]

    enum CodingKeys: String, CodingKey {
        case colleges = "colleges"
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
        colleges: [College]? = nil
    ) -> CollegeData {
        return CollegeData(
            colleges: colleges ?? self.colleges
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
// MARK: - College
struct College: Codable {
        let unitid: Int
        let opeid: Int
        let opeid6: Int
        let instnm: String
        let city: String
        let stabbr: String
        let zip: String
        let accredagency: String
        let insturl: String
        let npcurl: String
        let schDeg: Int
        let hcm2: Int
        let main: Int
        let numbranch: Int
        let preddeg: Int
        let highdeg: Int
        let control: Int
        let stFIPS: Int
        let region: Int
        let locale: Int
        let locale2: Int
        let latitude: Double
        let longitude: Double
        let ccbasic: Int
        let ccugprof: Int
        let ccsizset: Int
        let hbcu: Int
        let pbi: Int
        let annhi: Int
        let tribal: Int
        let aanapii: Int
        let hsi: Int
        let nanti: Int
        let menonly: Int
        let womenonly: Int
        let relaffil: String
        let admRate: Double
        let admRateAll: Double
        let satvr25: Int
        let satvr75: Int
        let satmt25: Int
        let satmt75: Int
        let satwr25: Int
        let satwr75: Int
        let satvrmid: Int
        let satmtmid: Int
        let satwrmid: Int
        let actcm25: Int
        let actcm75: Int
        let acten25: Int
        let acten75: Int
        let actmt25: Int
        let actmt75: Int
        let actwr25: Int
        let actwr75: Int
        let actcmmid: Int
        let actenmid: Int
        let actmtmid: Int
        let actwrmid: Int
        let satAvg: Int
        let satAvgAll: Int
        let distanceonly: Int
        let curroper: Int
        let costt4A: Int
        let costt4P: Int
        let tuitionfeeIn: Double
        let tuitionfeeOut: Double
        let tuitionfeeProg: Double
        let tuitfte: Int
        let inexpfte: Int
        let avgfacsal: Int
        let pftfac: Double
        let pctpell: Double
        let ageEntry: Double
        let ageEntrySq: Double
        let agege24: Double
        let female: Double
        let married: Double
        let dependent: Double
        let veteran: Double
        let firstGen: Double
        let faminc: Double
        let mdFaminc: Double
        let famincInd: Double
        let lnfaminc: Double
        let lnfamincInd: String
        let pctWhite: Double
        let pctBlack: Double
        let pctAsian: Double
        let pctHispanic: Double
        let pctBa: Double
        let pctGradProf: Double
        let pctBornUs: Double
        let medianHhInc: Double
        let povertyRate: Double
        let unempRate: Double
        let lnMedianHhInc: Double
        let alias: String
        let openadmp: Int
        let ugnonds: Int
        let grads: Int
        let accredcode: String
        let empty: String

        enum CodingKeys: String, CodingKey {
            case unitid = "UNITID"
            case opeid = "OPEID"
            case opeid6 = "OPEID6"
            case instnm = "INSTNM"
            case city = "CITY"
            case stabbr = "STABBR"
            case zip = "ZIP"
            case accredagency = "ACCREDAGENCY"
            case insturl = "INSTURL"
            case npcurl = "NPCURL"
            case schDeg = "SCH_DEG"
            case hcm2 = "HCM2"
            case main = "MAIN"
            case numbranch = "NUMBRANCH"
            case preddeg = "PREDDEG"
            case highdeg = "HIGHDEG"
            case control = "CONTROL"
            case stFIPS = "ST_FIPS"
            case region = "REGION"
            case locale = "LOCALE"
            case locale2 = "LOCALE2"
            case latitude = "LATITUDE"
            case longitude = "LONGITUDE"
            case ccbasic = "CCBASIC"
            case ccugprof = "CCUGPROF"
            case ccsizset = "CCSIZSET"
            case hbcu = "HBCU"
            case pbi = "PBI"
            case annhi = "ANNHI"
            case tribal = "TRIBAL"
            case aanapii = "AANAPII"
            case hsi = "HSI"
            case nanti = "NANTI"
            case menonly = "MENONLY"
            case womenonly = "WOMENONLY"
            case relaffil = "RELAFFIL"
            case admRate = "ADM_RATE"
            case admRateAll = "ADM_RATE_ALL"
            case satvr25 = "SATVR25"
            case satvr75 = "SATVR75"
            case satmt25 = "SATMT25"
            case satmt75 = "SATMT75"
            case satwr25 = "SATWR25"
            case satwr75 = "SATWR75"
            case satvrmid = "SATVRMID"
            case satmtmid = "SATMTMID"
            case satwrmid = "SATWRMID"
            case actcm25 = "ACTCM25"
            case actcm75 = "ACTCM75"
            case acten25 = "ACTEN25"
            case acten75 = "ACTEN75"
            case actmt25 = "ACTMT25"
            case actmt75 = "ACTMT75"
            case actwr25 = "ACTWR25"
            case actwr75 = "ACTWR75"
            case actcmmid = "ACTCMMID"
            case actenmid = "ACTENMID"
            case actmtmid = "ACTMTMID"
            case actwrmid = "ACTWRMID"
            case satAvg = "SAT_AVG"
            case satAvgAll = "SAT_AVG_ALL"
            case distanceonly = "DISTANCEONLY"
            case curroper = "CURROPER"
            case costt4A = "COSTT4_A"
            case costt4P = "COSTT4_P"
            case tuitionfeeIn = "TUITIONFEE_IN"
            case tuitionfeeOut = "TUITIONFEE_OUT"
            case tuitionfeeProg = "TUITIONFEE_PROG"
            case tuitfte = "TUITFTE"
            case inexpfte = "INEXPFTE"
            case avgfacsal = "AVGFACSAL"
            case pftfac = "PFTFAC"
            case pctpell = "PCTPELL"
            case ageEntry = "AGE_ENTRY"
            case ageEntrySq = "AGE_ENTRY_SQ"
            case agege24 = "AGEGE24"
            case female = "FEMALE"
            case married = "MARRIED"
            case dependent = "DEPENDENT"
            case veteran = "VETERAN"
            case firstGen = "FIRST_GEN"
            case faminc = "FAMINC"
            case mdFaminc = "MD_FAMINC"
            case famincInd = "FAMINC_IND"
            case lnfaminc = "LNFAMINC"
            case lnfamincInd = "LNFAMINC_IND"
            case pctWhite = "PCT_WHITE"
            case pctBlack = "PCT_BLACK"
            case pctAsian = "PCT_ASIAN"
            case pctHispanic = "PCT_HISPANIC"
            case pctBa = "PCT_BA"
            case pctGradProf = "PCT_GRAD_PROF"
            case pctBornUs = "PCT_BORN_US"
            case medianHhInc = "MEDIAN_HH_INC"
            case povertyRate = "POVERTY_RATE"
            case unempRate = "UNEMP_RATE"
            case lnMedianHhInc = "LN_MEDIAN_HH_INC"
            case alias = "ALIAS"
            case openadmp = "OPENADMP"
            case ugnonds = "UGNONDS"
            case grads = "GRADS"
            case accredcode = "ACCREDCODE"
            case empty = ""
        }
    }

    // MARK: College convenience initializers and mutators

    extension College {
        init(data: Data) throws {
            self = try newJSONDecoder().decode(College.self, from: data)
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
            unitid: String? = nil,
            opeid: String? = nil,
            opeid6: String? = nil,
            instnm: String? = nil,
            city: String? = nil,
            stabbr: String? = nil,
            zip: String? = nil,
            accredagency: String? = nil,
            insturl: String? = nil,
            npcurl: String? = nil,
            schDeg: String? = nil,
            hcm2: String? = nil,
            main: String? = nil,
            numbranch: String? = nil,
            preddeg: String? = nil,
            highdeg: String? = nil,
            control: String? = nil,
            stFIPS: String? = nil,
            region: String? = nil,
            locale: String? = nil,
            locale2: String? = nil,
            latitude: String? = nil,
            longitude: String? = nil,
            ccbasic: String? = nil,
            ccugprof: String? = nil,
            ccsizset: String? = nil,
            hbcu: String? = nil,
            pbi: String? = nil,
            annhi: String? = nil,
            tribal: String? = nil,
            aanapii: String? = nil,
            hsi: String? = nil,
            nanti: String? = nil,
            menonly: String? = nil,
            womenonly: String? = nil,
            relaffil: String? = nil,
            admRate: String? = nil,
            admRateAll: String? = nil,
            satvr25: String? = nil,
            satvr75: String? = nil,
            satmt25: String? = nil,
            satmt75: String? = nil,
            satwr25: String? = nil,
            satwr75: String? = nil,
            satvrmid: String? = nil,
            satmtmid: String? = nil,
            satwrmid: String? = nil,
            actcm25: String? = nil,
            actcm75: String? = nil,
            acten25: String? = nil,
            acten75: String? = nil,
            actmt25: String? = nil,
            actmt75: String? = nil,
            actwr25: String? = nil,
            actwr75: String? = nil,
            actcmmid: String? = nil,
            actenmid: String? = nil,
            actmtmid: String? = nil,
            actwrmid: String? = nil,
            satAvg: String? = nil,
            satAvgAll: String? = nil,
            distanceonly: String? = nil,
            curroper: String? = nil,
            costt4A: String? = nil,
            costt4P: String? = nil,
            tuitionfeeIn: String? = nil,
            tuitionfeeOut: String? = nil,
            tuitionfeeProg: String? = nil,
            tuitfte: String? = nil,
            inexpfte: String? = nil,
            avgfacsal: String? = nil,
            pftfac: String? = nil,
            pctpell: String? = nil,
            ageEntry: String? = nil,
            ageEntrySq: String? = nil,
            agege24: String? = nil,
            female: String? = nil,
            married: String? = nil,
            dependent: String? = nil,
            veteran: String? = nil,
            firstGen: String? = nil,
            faminc: String? = nil,
            mdFaminc: String? = nil,
            famincInd: String? = nil,
            lnfaminc: String? = nil,
            lnfamincInd: String? = nil,
            pctWhite: String? = nil,
            pctBlack: String? = nil,
            pctAsian: String? = nil,
            pctHispanic: String? = nil,
            pctBa: String? = nil,
            pctGradProf: String? = nil,
            pctBornUs: String? = nil,
            medianHhInc: String? = nil,
            povertyRate: String? = nil,
            unempRate: String? = nil,
            lnMedianHhInc: String? = nil,
            alias: String? = nil,
            openadmp: String? = nil,
            ugnonds: String? = nil,
            grads: String? = nil,
            accredcode: String? = nil,
            empty: String? = nil
    ) -> College {
        let formatter = NumberFormatter()
        
        return College(
            unitid: formatter.number(from: unitid!) as? Int ?? self.unitid,
            opeid: formatter.number(from: opeid!) as? Int ?? self.opeid,
            opeid6: formatter.number(from: opeid6!) as? Int ?? self.opeid6,
            instnm: instnm ?? self.instnm,
            city: city ?? self.city,
            stabbr: stabbr ?? self.stabbr,
            zip: zip ?? self.zip,
            accredagency: accredagency ?? self.accredagency,
            insturl: insturl ?? self.insturl,
            npcurl: npcurl ?? self.npcurl,
            schDeg: formatter.number(from: schDeg!) as? Int ?? self.schDeg,
            hcm2: formatter.number(from: hcm2!) as? Int ?? self.hcm2,
            main: formatter.number(from: main!) as? Int ?? self.main,
            numbranch: formatter.number(from: numbranch!) as? Int ?? self.numbranch,
            preddeg: formatter.number(from: preddeg!) as? Int ?? self.preddeg,
            highdeg: formatter.number(from: highdeg!) as? Int ?? self.highdeg,
            control: formatter.number(from: control!) as? Int ?? self.control,
            stFIPS: formatter.number(from: stFIPS!) as? Int ?? self.stFIPS,
            region: formatter.number(from: region!) as? Int ?? self.region,
            locale: formatter.number(from: locale!) as? Int ?? self.locale,
            locale2: formatter.number(from: locale2!) as? Int ?? self.locale2,
            latitude: formatter.number(from: latitude!) as? Double ?? self.latitude,
            longitude: formatter.number(from: longitude!) as? Double ?? self.longitude,
            ccbasic: formatter.number(from: ccbasic!) as? Int ?? self.ccbasic,
            ccugprof: formatter.number(from: ccugprof!) as? Int ?? self.ccugprof,
            ccsizset: formatter.number(from: ccsizset!) as? Int ?? self.ccsizset,
            hbcu: formatter.number(from: hbcu!) as? Int ?? self.hbcu,
            pbi: formatter.number(from: pbi!) as? Int ?? self.pbi,
            annhi: formatter.number(from: annhi!) as? Int ?? self.annhi,
            tribal: formatter.number(from: tribal!) as? Int ?? self.tribal,
            aanapii: formatter.number(from: aanapii!) as? Int ?? self.aanapii,
            hsi: formatter.number(from: hsi!) as? Int ?? self.hsi,
            nanti: formatter.number(from: nanti!) as? Int ?? self.nanti,
            menonly: formatter.number(from: menonly!) as? Int ?? self.menonly,
            womenonly: formatter.number(from: womenonly!) as? Int ?? self.womenonly,
            relaffil: relaffil ?? self.relaffil,
            admRate: formatter.number(from: admRate!) as? Double ?? self.admRate,
            admRateAll: formatter.number(from: admRateAll!) as? Double ?? self.admRateAll,
            satvr25: formatter.number(from: satvr25!) as? Int ?? self.satvr25,
            satvr75: formatter.number(from: satvr75!) as? Int ?? self.satvr75,
            satmt25: formatter.number(from: satmt25!) as? Int ?? self.satmt25,
            satmt75: formatter.number(from: satmt75!) as? Int ?? self.satmt75,
            satwr25: formatter.number(from: satwr25!) as? Int ?? self.satwr25,
            satwr75: formatter.number(from: satwr75!) as? Int ?? self.satwr75,
            satvrmid: formatter.number(from: satvrmid!) as? Int ?? self.satvrmid,
            satmtmid: formatter.number(from: satmtmid!) as? Int ?? self.satmtmid,
            satwrmid: formatter.number(from: satwrmid!) as? Int ?? self.satwrmid,
            actcm25: formatter.number(from: actcm25!) as? Int ?? self.actcm25,
            actcm75: formatter.number(from: actcm75!) as? Int ?? self.actcm75,
            acten25: formatter.number(from: acten25!) as? Int ?? self.acten25,
            acten75: formatter.number(from: acten75!) as? Int ?? self.acten75,
            actmt25: formatter.number(from: actmt25!) as? Int ?? self.actmt25,
            actmt75: formatter.number(from: actmt75!) as? Int ?? self.actmt75,
            actwr25: formatter.number(from: actwr25!) as? Int ?? self.actwr25,
            actwr75: formatter.number(from: actwr75!) as? Int ?? self.actwr75,
            actcmmid: formatter.number(from: actcmmid!) as? Int ?? self.actcmmid,
            actenmid: formatter.number(from: actenmid!) as? Int ?? self.actenmid,
            actmtmid: formatter.number(from: actmtmid!) as? Int ?? self.actmtmid,
            actwrmid: formatter.number(from: actwrmid!) as? Int ?? self.actwrmid,
            satAvg: formatter.number(from: satAvg!) as? Int ?? self.satAvg,
            satAvgAll: formatter.number(from: satAvgAll!) as? Int ?? self.satAvgAll,
            distanceonly: formatter.number(from: distanceonly!) as? Int ?? self.distanceonly,
            curroper: formatter.number(from: curroper!) as? Int ?? self.curroper,
            costt4A: formatter.number(from: costt4A!) as? Int ?? self.costt4A,
            costt4P: formatter.number(from: costt4P!) as? Int ?? self.costt4P,
            tuitionfeeIn: formatter.number(from: tuitionfeeIn!) as? Double ?? self.tuitionfeeIn,
            tuitionfeeOut: formatter.number(from: tuitionfeeOut!) as? Double ?? self.tuitionfeeOut,
            tuitionfeeProg: formatter.number(from: tuitionfeeProg!) as? Double ?? self.tuitionfeeProg,
            tuitfte: formatter.number(from: tuitfte!) as? Int ?? self.tuitfte,
            inexpfte: formatter.number(from: inexpfte!) as? Int ?? self.inexpfte,
            avgfacsal: formatter.number(from: avgfacsal!) as? Int ?? self.avgfacsal,
            pftfac: formatter.number(from: pftfac!) as? Double ?? self.pftfac,
            pctpell: formatter.number(from: pctpell!) as? Double ?? self.pctpell,
            ageEntry: formatter.number(from: ageEntry!) as? Double ?? self.ageEntry,
            ageEntrySq: formatter.number(from: ageEntrySq!) as? Double ?? self.ageEntrySq,
            agege24: formatter.number(from: agege24!) as? Double ?? self.agege24,
            female: formatter.number(from: female!) as? Double ?? self.female,
            married: formatter.number(from: married!) as? Double ?? self.married,
            dependent: formatter.number(from: dependent!) as? Double ?? self.dependent,
            veteran: formatter.number(from: veteran!) as? Double ?? self.veteran,
            firstGen: formatter.number(from: firstGen!) as? Double ?? self.firstGen,
            faminc: formatter.number(from: faminc!) as? Double ?? self.faminc,
            mdFaminc: formatter.number(from: mdFaminc!) as? Double ?? self.mdFaminc,
            famincInd: formatter.number(from: famincInd!) as? Double ?? self.famincInd,
            lnfaminc: formatter.number(from: lnfaminc!) as? Double ?? self.lnfaminc,
            lnfamincInd: lnfamincInd ?? self.lnfamincInd,
            pctWhite: formatter.number(from: pctWhite!) as? Double ?? self.pctWhite,
            pctBlack: formatter.number(from: pctBlack!) as? Double ?? self.pctBlack,
            pctAsian: formatter.number(from: pctWhite!) as? Double ?? self.pctAsian,
            pctHispanic: formatter.number(from: pctHispanic!) as? Double ?? self.pctHispanic,
            pctBa: formatter.number(from: pctBa!) as? Double ?? self.pctBa,
            pctGradProf: formatter.number(from: pctGradProf!) as? Double ?? self.pctGradProf,
            pctBornUs: formatter.number(from: pctBornUs!) as? Double ?? self.pctBornUs,
            medianHhInc: formatter.number(from: medianHhInc!) as? Double ?? self.medianHhInc,
            povertyRate: formatter.number(from: povertyRate!) as? Double ?? self.povertyRate,
            unempRate: formatter.number(from: unempRate!) as? Double ?? self.unempRate,
            lnMedianHhInc: formatter.number(from: lnMedianHhInc!) as? Double ?? self.lnMedianHhInc,
            alias: alias ?? self.alias,
            openadmp: formatter.number(from: openadmp!) as? Int ?? self.openadmp,
            ugnonds: formatter.number(from: ugnonds!) as? Int ?? self.ugnonds,
            grads: formatter.number(from: grads!) as? Int ?? self.grads,
            accredcode: accredcode ?? self.accredcode,
            empty: empty ?? self.empty
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
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
 
