//
//  DateExtensionTests.swift
//  EventListDemoTests
//
//  Created by Maryia Bahlai
//

import XCTest
@testable import EventListDemo

class DateExtensionTests: XCTestCase {

    func testGetStringWithValidFormat() {
        let date = Date()
        let dateString = date.getString(.yyyymmddThhmmss)
        XCTAssertNotNil(dateString, "Date string should be generated for a valid format")
    }

    func testConvertToDifferentTimeZone() {
        let date = Date()
        let initialTimeZone = TimeZone(identifier: "GMT")!
        let destinationTimeZone = TimeZone(identifier: "PST")!
        let convertedDate = date.convert(from: initialTimeZone, to: destinationTimeZone).convert(from: destinationTimeZone, to: initialTimeZone)
        
        XCTAssertEqual(convertedDate, date)
    }

    func testConvertToSameTimeZone() {
        let date = Date()
        let initialTimeZone = TimeZone(identifier: "GMT")!
        let convertedDate = date.convert(from: initialTimeZone, to: initialTimeZone)
        
        XCTAssertEqual(date, convertedDate, "Converted date should be the same as the original date for the same time zone")
    }

    func testConvertAcrossDST() {
        let date = Date(timeIntervalSince1970: 1615791600)
        let initialTimeZone = TimeZone(identifier: "GMT")!
        let destinationTimeZone = TimeZone(identifier: "CET")!
        let convertedDate = date.convert(from: initialTimeZone, to: destinationTimeZone)
        
        let expectedDate = Date(timeIntervalSince1970: 1615788000)
        XCTAssertEqual(convertedDate, expectedDate, "Converted date should consider DST changes")
    }
}
