//
//  EventListViewModelTests.swift
//  EventListDemoTests
//
//  Created by Maryia Bahlai
//

import XCTest
@testable import EventListDemo

@MainActor
final class EventListViewModelTests: XCTestCase {
    
    struct MockEventService: EventServiceInterface {
        var eventList: [Event] = []
        
        func getEventList() async throws -> [Event] {
            eventList
        }
    }
    
    struct MockFailingEventService: EventServiceInterface {
        func getEventList() async throws -> [Event] {
            throw NetworkRequestError.unknownError
        }
    }
    

    func testEventListInitiallyEmpty() {
        let eventService = MockEventService(eventList: [])
        let viewModel = EventListViewModel(eventService: eventService)
        
        XCTAssertTrue(viewModel.eventList.isEmpty, "Event list should be initially empty")
    }
    
    func testFetchEventListSuccess() async {
        let mockEvent = Event(id: 0, title: "Test")
        let eventService = MockEventService(eventList: [mockEvent])
        let viewModel = EventListViewModel(eventService: eventService)
        
        await viewModel.onAppear()
        
        XCTAssertFalse(viewModel.eventList.isEmpty, "Event list should not be empty after fetching")
    }

    func testIsLoadingWhileFetching() async {
        let eventService = MockEventService(eventList: [])
        let viewModel = EventListViewModel(eventService: eventService)
        
        Task {
            await viewModel.onAppear()
            XCTAssertTrue(viewModel.isLoading, "isLoading should be true while fetching event list")
        }
    }

    func testIsLoadingAfterFetching() async {
        let eventService = MockEventService(eventList: [])
        let viewModel = EventListViewModel(eventService: eventService)
        
        Task {
            await viewModel.onAppear()
            XCTAssertFalse(viewModel.isLoading, "isLoading should be false after fetching event list")
        }
    }

    func testFetchEventListFailure() async {
        let eventService = MockFailingEventService()
        let viewModel = EventListViewModel(eventService: eventService)
        
        await viewModel.onAppear()
        
        XCTAssertTrue(viewModel.eventList.isEmpty, "Event list should be empty on fetch failure")
    }
}
