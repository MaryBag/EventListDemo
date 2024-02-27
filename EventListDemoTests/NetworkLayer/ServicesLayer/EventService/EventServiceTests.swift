//
//  EventServiceTests.swift
//  EventListDemoTests
//
//  Created by Maryia Bahlai
//

import XCTest
@testable import EventListDemo

class EventServiceTests: XCTestCase {
    
    class MockApiClient: ApiClientInterface {
        var response: Decodable = Events(events: [])
        
        func execute<EndPoint: EndPointInterface, Model: Decodable>(for route: EndPoint) async throws -> Model {
            if let response = response as? Model {
                return response
            } else {
                throw NetworkRequestError.unknownError
            }
        }
    }
    
    class MockEndPoint: EndPointInterface {
        var baseURL: URL = URL(string: "https://example.com")!
        var path: String?
        var httpMethod: EventListDemo.HTTPMethod = .get
        var task: EventListDemo.HTTPTask = .requestParameters(urlParameters: nil)
        var headers: EventListDemo.Parameters?
    }
    
    func testGetEventListSuccess() async {
        let apiClient = MockApiClient()
        let event = Event(id: 0)
        apiClient.response = Events(events: [event])
        let eventService = EventService(apiClient)
        
        do {
            let events: [Event] = try await eventService.getEventList()
            XCTAssertEqual(events, [event])
        } catch {
            XCTFail("Retrieving event list should not throw an error for a successful request")
        }
    }
    
    func testGetEventListFailure() async {
        let apiClient = MockApiClient()
        apiClient.response = "Test"
        let eventService = EventService(apiClient)
        
        do {
            let _: [Event] = try await eventService.getEventList()
            XCTFail("Retrieving event list should throw an error for a failed request")
        } catch {
            XCTAssertEqual(error as? NetworkRequestError, NetworkRequestError.unknownError)
        }
    }
}
