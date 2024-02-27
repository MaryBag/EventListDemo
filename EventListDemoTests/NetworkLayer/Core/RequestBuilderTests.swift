//
//  RequestBuilderTests.swift
//  EventListDemoTests
//
//  Created by Maryia Bahlai
//

import XCTest
@testable import EventListDemo

class RequestBuilderTests: XCTestCase {
    struct MockEndPoint: EndPointInterface {
        var baseURL: URL
        var path: String?
        var httpMethod: EventListDemo.HTTPMethod
        var task: EventListDemo.HTTPTask
        var headers: EventListDemo.Parameters?
    }
    
    var requestBuilder: RequestBuilder!

    override func setUp() {
        super.setUp()
        requestBuilder = RequestBuilder()
    }

    override func tearDown() {
        requestBuilder = nil
        super.tearDown()
    }

    func testBuildGetRequest() {
        // Given
        let expectedURL = URL(string: "https://example.com")!
        let mockEndPoint = MockEndPoint(baseURL: expectedURL, path: "/test", httpMethod: .get, task: .requestParameters(urlParameters: ["param1": "value1"]), headers: ["Authorization": "Bearer token"])

        // When
        let request = requestBuilder.buildRequest(from: mockEndPoint)

        // Then
        XCTAssertEqual(request.url?.path(), "/test")
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.allHTTPHeaderFields?["Authorization"], "Bearer token")
        XCTAssertEqual(request.url?.query, "param1=value1")
    }
    
    func testBuildPostRequest() {
        // Given
        let expectedURL = URL(string: "https://example.com")!
        let mockEndPoint = MockEndPoint(baseURL: expectedURL, path: "/test", httpMethod: .post, task: .requestParameters(urlParameters: ["param1": "value1"]), headers: ["Authorization": "Bearer token"])

        // When
        let request = requestBuilder.buildRequest(from: mockEndPoint)

        // Then
        XCTAssertEqual(request.url?.path(), "/test")
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.allHTTPHeaderFields?["Authorization"], "Bearer token")
        XCTAssertEqual(request.url?.query, "param1=value1")
    }
    
    func testBuildNoPathRequest() {
        // Given
        let expectedURL = URL(string: "https://example.com")!
        let mockEndPoint = MockEndPoint(baseURL: expectedURL, path: nil, httpMethod: .post, task: .requestParameters(urlParameters: ["param1": "value1"]), headers: ["Authorization": "Bearer token"])

        // When
        let request = requestBuilder.buildRequest(from: mockEndPoint)

        // Then
        XCTAssertEqual(request.url?.path(), "")
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.allHTTPHeaderFields?["Authorization"], "Bearer token")
        XCTAssertEqual(request.url?.query, "param1=value1")
    }
    
    func testBuildNoHeadersRequest() {
        // Given
        let expectedURL = URL(string: "https://example.com")!
        let mockEndPoint = MockEndPoint(baseURL: expectedURL, path: nil, httpMethod: .post, task: .requestParameters(urlParameters: ["param1": "value1"]), headers: nil)

        // When
        let request = requestBuilder.buildRequest(from: mockEndPoint)

        // Then
        XCTAssertEqual(request.url?.path(), "")
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.allHTTPHeaderFields, [:])
        XCTAssertEqual(request.url?.query, "param1=value1")
    }
    
    func testBuildNoUrlParametersRequest() {
        // Given
        let expectedURL = URL(string: "https://example.com")!
        let mockEndPoint = MockEndPoint(baseURL: expectedURL, path: nil, httpMethod: .post, task: .requestParameters(urlParameters: nil), headers: nil)

        // When
        let request = requestBuilder.buildRequest(from: mockEndPoint)

        // Then
        XCTAssertEqual(request.url?.path(), "")
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.allHTTPHeaderFields, [:])
        XCTAssertEqual(request.url?.query, nil)
    }
}
