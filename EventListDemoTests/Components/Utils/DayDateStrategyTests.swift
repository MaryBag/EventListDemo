//
//  DayDateStrategyTests.swift
//  EventListDemoTests
//
//  Created by Maryia Bahlai
//

import XCTest
@testable import EventListDemo

class DayDateStrategyTests: XCTestCase {

    func testDecodeValidDateString() {
        let dateString = "2022-01-01T12:00:00"
        do {
            let date = try DayDateStrategy.decode(dateString)
            XCTAssertNotNil(date, "Date should be decoded successfully from a valid string")
        } catch {
            XCTFail("Decoding should not throw an error for a valid string")
        }
    }

    func testDecodeNilDateString() {
        let dateString: String? = nil
        do {
            let date = try DayDateStrategy.decode(dateString)
            XCTAssertNil(date, "Decoding should return nil for a nil string")
        } catch {
            XCTFail("Decoding should not throw an error for a nil string")
        }
    }

    func testEncodeValidDate() {
        let date = Date()
        let dateString = DayDateStrategy.encode(date)
        XCTAssertNotNil(dateString, "Encoding should return a valid string for a valid date")
    }

    func testEncodeNilDate() {
        let date: Date? = nil
        let dateString = DayDateStrategy.encode(date)
        XCTAssertNil(dateString, "Encoding should return nil for a nil date")
    }

    func testDecodeAndEncodeConsistency() {
        let dateString = "2022-01-01T12:00:00"
        do {
            let date = try DayDateStrategy.decode(dateString)
            let encodedString = DayDateStrategy.encode(date)
            XCTAssertEqual(dateString, encodedString, "Decoding and encoding should be consistent")
        } catch {
            XCTFail("Decoding should not throw an error for a valid string")
        }
    }
}
