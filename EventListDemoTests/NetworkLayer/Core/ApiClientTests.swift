//
//  ApiClientTests.swift
//  EventListDemoTests
//
//  Created by Maryia Bahlai
//

import XCTest
@testable import EventListDemo

class ApiClientTests: XCTestCase {
    
    class MockRequestBuilder: RequestBuilderInterface {
        func buildRequest<EndPoint: EndPointInterface>(from route: EndPoint) -> URLRequest {
            return URLRequest(url: URL(string: "https://example.com")!)
        }
    }
    
    class MockRequestExecutor: RequestExecutorInterface {
        var data: Data = .init()
        var response: URLResponse = .init()
        
        func execute(for request: URLRequest) async throws -> (Data, URLResponse) {
            return (data, response)
        }
    }
    
    class MockErrorHandler: ErrorHandlerInterface {
        var error: EventListDemo.NetworkRequestError?
        
        func requestError(_ error: Error) -> EventListDemo.NetworkRequestError {
            if let error = error as? NetworkRequestError {
                return error
            }
            return .unknownError
        }
        
        func httpError(_ response: URLResponse) -> EventListDemo.NetworkRequestError? {
            error
        }
        
        func decodingError(_ error: Error) -> EventListDemo.NetworkRequestError {
            if let error = error as? NetworkRequestError {
                return error
            }
            return .decodingError(error.localizedDescription)
        }
    }
    
    class MockEndPoint: EndPointInterface {
        var baseURL: URL = URL(string: "https://example.com")!
        var path: String?
        var httpMethod: EventListDemo.HTTPMethod = .get
        var task: EventListDemo.HTTPTask = .requestParameters(urlParameters: nil)
        var headers: EventListDemo.Parameters?
    }
    
    func testExecuteSuccessfulRequest() async {
        let requestExecutor = MockRequestExecutor()
        let events = Events(events: [Event(id: 0, title: "Test", datetime_utc: Date())])
        requestExecutor.data = (try? JSONEncoder().encode(events)) ?? Data()
        let apiClient = ApiClient(MockRequestBuilder(), requestExecutor, MockErrorHandler())
        
        do {
            let result: Events = try await apiClient.execute(for: MockEndPoint())
            XCTAssertEqual(result, events)
        } catch {
            XCTFail("Execution should not throw an error for a successful request")
        }
    }
    
    func testExecuteFailedRequest() async {
        let requestExecutor = MockRequestExecutor()
        let errorHandler = MockErrorHandler()
        errorHandler.error = .notFound
        let apiClient = ApiClient(MockRequestBuilder(), MockRequestExecutor(), errorHandler)
        
        do {
            let _ : Events = try await apiClient.execute(for: MockEndPoint())
            XCTFail("Execution should throw an error for a failed request")
        } catch {
            XCTAssertEqual(error as? NetworkRequestError, errorHandler.error)
        }
    }
    
    func testDecodingError() async {
        let requestExecutor = MockRequestExecutor()
        requestExecutor.data = (try? JSONEncoder().encode("Test")) ?? Data()
        let apiClient = ApiClient(MockRequestBuilder(), requestExecutor, MockErrorHandler())
        let endpoint = MockEndPoint()
        
        do {
            let _ : Events = try await apiClient.execute(for: endpoint)
            XCTFail("Execution should throw a decoding error")
        } catch {
            XCTAssertTrue(error is NetworkRequestError)
        }
    }
}
