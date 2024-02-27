//
//  EventViewModelTests.swift
//  EventListDemoTests
//
//  Created by Maryia Bahlai
//

import XCTest
@testable import EventListDemo

class EventViewModelTests: XCTestCase {
    var eventViewModel: EventViewModel!

    override func setUp() {
        super.setUp()
        let date = (try? DayDateStrategy.decode("2024-01-01T12:00:00")) ?? Date()
        let mockEvent = Event(id: 0, title: "Mock Event", datetime_utc: date, venue: EventVenue(display_location: "Mock Venue", timezone: "America/Los_Angeles"))
        eventViewModel = EventViewModel(mockEvent)
    }

    override func tearDown() {
        eventViewModel = nil
        super.tearDown()
    }

    func testTitle() {
        let expectedTitle = "Mock Event"
        let title = eventViewModel.title
        XCTAssertEqual(title, expectedTitle)
    }
    
    func testEmptyTitle() {
        let mockEvent = Event(id: 0)
        eventViewModel = EventViewModel(mockEvent)
        let title = eventViewModel.title
        XCTAssertEqual(title, "")
    }

    func testLocation() {
        let expectedLocation = "Mock Venue"
        let location = eventViewModel.location
        XCTAssertEqual(location, expectedLocation)
    }
    
    func testEmptyLocation() {
        let mockEvent = Event(id: 0)
        eventViewModel = EventViewModel(mockEvent)
        let location = eventViewModel.location
        XCTAssertEqual(location, nil)
    }

    func testDate() {
        let expectedDate = "January 01, 2024"
        let date = eventViewModel.date
        XCTAssertEqual(date, expectedDate)
    }
    
    func testEmptyDate() {
        let mockEvent = Event(id: 0)
        eventViewModel = EventViewModel(mockEvent)
        let date = eventViewModel.date
        XCTAssertEqual(date, nil)
    }

    func testTime() {
        let expectedTime = "08:00 pm"
        let time = eventViewModel.time
        XCTAssertEqual(time, expectedTime)
    }
    
    func testEmptyTimeZone() {
        let date = (try? DayDateStrategy.decode("2024-01-01T12:00:00")) ?? Date()
        let mockEvent = Event(id: 0, title: "Mock Event", datetime_utc: date)
        let expectedTime = "08:00 pm"
        let time = eventViewModel.time
        XCTAssertEqual(time, expectedTime)
    }
}
