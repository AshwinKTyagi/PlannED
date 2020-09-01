// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let collegeData = try CollegeData(json)

import Foundation

// MARK: - CollegeData
struct CollegeData: Codable {
    let collegeData: [String: CollegeDatum]
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
        collegeData: [String: CollegeDatum]? = nil
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

// MARK: - CollegeDatum
struct CollegeDatum: Codable {
    let opeid, opeid6: Int
    let instnm, city, stabbr, zip: String
    let accredagency: String
    let insturl: String
    let npcurl: String
    let schDeg, hcm2, main, numbranch: String
    let preddeg, highdeg, control, stFIPS: String
    let region, locale, locale2, latitude: String
    let longitude, ccbasic, ccugprof, ccsizset: String
    let hbcu, pbi, annhi, tribal: String
    let aanapii, hsi, nanti, menonly: String
    let womenonly, relaffil, admRate, admRateAll: String
    let satvr25, satvr75, satmt25, satmt75: Int
    let satwr25, satwr75, satvrmid, satmtmid: Int
    let satwrmid, actcm25, actcm75, acten25: Int
    let acten75, actmt25, actmt75, actwr25: Int
    let actwr75, actcmmid, actenmid, actmtmid: Int
    let actwrmid, satAvg, satAvgAll: Int
    let distanceonly, curroper, costt4A, costt4P: String
    let tuitionfeeIn, tuitionfeeOut, tuitionfeeProg, tuitfte: String
    let inexpfte, avgfacsal, pftfac, pctpell: String
    let ageEntry, ageEntrySq, agege24, female: String
    let married, dependent, veteran, firstGen: String
    let faminc, mdFaminc, famincInd, lnfaminc: String
    let lnfamincInd, pctWhite, pctBlack, pctAsian: String
    let pctHispanic, pctBa, pctGradProf, pctBornUs: String
    let medianHhInc, povertyRate, unempRate, lnMedianHhInc: String
    let alias, openadmp, ugnonds, grads: String
    let accredcode, empty: String

    enum CodingKeys: String, CodingKey {
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

// MARK: CollegeDatum convenience initializers and mutators

extension CollegeDatum {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CollegeDatum.self, from: data)
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
        opeid: Int? = nil,
        opeid6: Int? = nil,
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
        satvr25: Int? = nil,
        satvr75: Int? = nil,
        satmt25: Int? = nil,
        satmt75: Int? = nil,
        satwr25: Int? = nil,
        satwr75: Int? = nil,
        satvrmid: Int? = nil,
        satmtmid: Int? = nil,
        satwrmid: Int? = nil,
        actcm25: Int? = nil,
        actcm75: Int? = nil,
        acten25: Int? = nil,
        acten75: Int? = nil,
        actmt25: Int? = nil,
        actmt75: Int? = nil,
        actwr25: Int? = nil,
        actwr75: Int? = nil,
        actcmmid: Int? = nil,
        actenmid: Int? = nil,
        actmtmid: Int? = nil,
        actwrmid: Int? = nil,
        satAvg: Int? = nil,
        satAvgAll: Int? = nil,
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
    ) -> CollegeDatum {
        return CollegeDatum(
            opeid: opeid ?? self.opeid,
            opeid6: opeid6 ?? self.opeid6,
            instnm: instnm ?? self.instnm,
            city: city ?? self.city,
            stabbr: stabbr ?? self.stabbr,
            zip: zip ?? self.zip,
            accredagency: accredagency ?? self.accredagency,
            insturl: insturl ?? self.insturl,
            npcurl: npcurl ?? self.npcurl,
            schDeg: schDeg ?? self.schDeg,
            hcm2: hcm2 ?? self.hcm2,
            main: main ?? self.main,
            numbranch: numbranch ?? self.numbranch,
            preddeg: preddeg ?? self.preddeg,
            highdeg: highdeg ?? self.highdeg,
            control: control ?? self.control,
            stFIPS: stFIPS ?? self.stFIPS,
            region: region ?? self.region,
            locale: locale ?? self.locale,
            locale2: locale2 ?? self.locale2,
            latitude: latitude ?? self.latitude,
            longitude: longitude ?? self.longitude,
            ccbasic: ccbasic ?? self.ccbasic,
            ccugprof: ccugprof ?? self.ccugprof,
            ccsizset: ccsizset ?? self.ccsizset,
            hbcu: hbcu ?? self.hbcu,
            pbi: pbi ?? self.pbi,
            annhi: annhi ?? self.annhi,
            tribal: tribal ?? self.tribal,
            aanapii: aanapii ?? self.aanapii,
            hsi: hsi ?? self.hsi,
            nanti: nanti ?? self.nanti,
            menonly: menonly ?? self.menonly,
            womenonly: womenonly ?? self.womenonly,
            relaffil: relaffil ?? self.relaffil,
            admRate: admRate ?? self.admRate,
            admRateAll: admRateAll ?? self.admRateAll,
            satvr25: satvr25 ?? self.satvr25,
            satvr75: satvr75 ?? self.satvr75,
            satmt25: satmt25 ?? self.satmt25,
            satmt75: satmt75 ?? self.satmt75,
            satwr25: satwr25 ?? self.satwr25,
            satwr75: satwr75 ?? self.satwr75,
            satvrmid: satvrmid ?? self.satvrmid,
            satmtmid: satmtmid ?? self.satmtmid,
            satwrmid: satwrmid ?? self.satwrmid,
            actcm25: actcm25 ?? self.actcm25,
            actcm75: actcm75 ?? self.actcm75,
            acten25: acten25 ?? self.acten25,
            acten75: acten75 ?? self.acten75,
            actmt25: actmt25 ?? self.actmt25,
            actmt75: actmt75 ?? self.actmt75,
            actwr25: actwr25 ?? self.actwr25,
            actwr75: actwr75 ?? self.actwr75,
            actcmmid: actcmmid ?? self.actcmmid,
            actenmid: actenmid ?? self.actenmid,
            actmtmid: actmtmid ?? self.actmtmid,
            actwrmid: actwrmid ?? self.actwrmid,
            satAvg: satAvg ?? self.satAvg,
            satAvgAll: satAvgAll ?? self.satAvgAll,
            distanceonly: distanceonly ?? self.distanceonly,
            curroper: curroper ?? self.curroper,
            costt4A: costt4A ?? self.costt4A,
            costt4P: costt4P ?? self.costt4P,
            tuitionfeeIn: tuitionfeeIn ?? self.tuitionfeeIn,
            tuitionfeeOut: tuitionfeeOut ?? self.tuitionfeeOut,
            tuitionfeeProg: tuitionfeeProg ?? self.tuitionfeeProg,
            tuitfte: tuitfte ?? self.tuitfte,
            inexpfte: inexpfte ?? self.inexpfte,
            avgfacsal: avgfacsal ?? self.avgfacsal,
            pftfac: pftfac ?? self.pftfac,
            pctpell: pctpell ?? self.pctpell,
            ageEntry: ageEntry ?? self.ageEntry,
            ageEntrySq: ageEntrySq ?? self.ageEntrySq,
            agege24: agege24 ?? self.agege24,
            female: female ?? self.female,
            married: married ?? self.married,
            dependent: dependent ?? self.dependent,
            veteran: veteran ?? self.veteran,
            firstGen: firstGen ?? self.firstGen,
            faminc: faminc ?? self.faminc,
            mdFaminc: mdFaminc ?? self.mdFaminc,
            famincInd: famincInd ?? self.famincInd,
            lnfaminc: lnfaminc ?? self.lnfaminc,
            lnfamincInd: lnfamincInd ?? self.lnfamincInd,
            pctWhite: pctWhite ?? self.pctWhite,
            pctBlack: pctBlack ?? self.pctBlack,
            pctAsian: pctAsian ?? self.pctAsian,
            pctHispanic: pctHispanic ?? self.pctHispanic,
            pctBa: pctBa ?? self.pctBa,
            pctGradProf: pctGradProf ?? self.pctGradProf,
            pctBornUs: pctBornUs ?? self.pctBornUs,
            medianHhInc: medianHhInc ?? self.medianHhInc,
            povertyRate: povertyRate ?? self.povertyRate,
            unempRate: unempRate ?? self.unempRate,
            lnMedianHhInc: lnMedianHhInc ?? self.lnMedianHhInc,
            alias: alias ?? self.alias,
            openadmp: openadmp ?? self.openadmp,
            ugnonds: ugnonds ?? self.ugnonds,
            grads: grads ?? self.grads,
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
    
    func ifNullOrPrivate(_ value: String) {
        if value == "NULL" || value == "PrivacySuppressed"{
            
        }
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
