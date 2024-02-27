//
//  ErrorHandlerTests.swift
//  EventListDemoTests
//
//  Created by Maryia Bahlai
//

import XCTest
@testable import EventListDemo

class ErrorHandlerTests: XCTestCase {
    var errorHandler: ErrorHandler!

    override func setUp() {
        super.setUp()
        errorHandler = ErrorHandler()
    }

    override func tearDown() {
        errorHandler = nil
        super.tearDown()
    }

    func testRequestError() {
        let error = NSError(domain: "test", code: 404, userInfo: nil)
        let networkRequestError = errorHandler.requestError(error)
        XCTAssertEqual(networkRequestError, .invalidRequest(error.localizedDescription))
    }
    
    func testHttpNoError() {
        let urlResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let networkRequestError = errorHandler.httpError(urlResponse)
        XCTAssertEqual(networkRequestError, nil)
    }
    
    func testHttpErrorBadRequest() {
        let urlResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 400, httpVersion: nil, headerFields: nil)!
        let networkRequestError = errorHandler.httpError(urlResponse)
        XCTAssertEqual(networkRequestError, .badRequest)
    }
    
    func testHttpErrorUnauthorized() {
        let urlResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 401, httpVersion: nil, headerFields: nil)!
        let networkRequestError = errorHandler.httpError(urlResponse)
        XCTAssertEqual(networkRequestError, .unauthorized)
    }
    
    func testHttpErrorForbidden() {
        let urlResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 403, httpVersion: nil, headerFields: nil)!
        let networkRequestError = errorHandler.httpError(urlResponse)
        XCTAssertEqual(networkRequestError, .forbidden)
    }

    func testHttpErrorNotFound() {
        let urlResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 404, httpVersion: nil, headerFields: nil)!
        let networkRequestError = errorHandler.httpError(urlResponse)
        XCTAssertEqual(networkRequestError, .notFound)
    }
    
    func httpError(_ response: URLResponse) -> NetworkRequestError? {
        guard let httpResponse = response as? HTTPURLResponse else {
            return .unknownError
        }
        let httpStatusCode = httpResponse.statusCode
        switch httpStatusCode {
        default: return .unknownError
        }
    }
    
    func testHttpError4xx() {
        let urlResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 402, httpVersion: nil, headerFields: nil)!
        let networkRequestError = errorHandler.httpError(urlResponse)
        XCTAssertEqual(networkRequestError, .error4xx(402))
    }
    
    func testHttpErrorServerError() {
        let urlResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
        let networkRequestError = errorHandler.httpError(urlResponse)
        XCTAssertEqual(networkRequestError, .serverError)
    }
    
    func testHttpError5xx() {
        let urlResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 501, httpVersion: nil, headerFields: nil)!
        let networkRequestError = errorHandler.httpError(urlResponse)
        XCTAssertEqual(networkRequestError, .error5xx(501))
    }
    
    func testHttpErrorUnknownError() {
        var urlResponse = URLResponse()
        var networkRequestError = errorHandler.httpError(urlResponse)
        XCTAssertEqual(networkRequestError, .unknownError)
        
        urlResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: -1, httpVersion: nil, headerFields: nil)!
        networkRequestError = errorHandler.httpError(urlResponse)
        XCTAssertEqual(networkRequestError, .unknownError)
    }
    

    func testDecodingError() {
        let error = NSError(domain: "test", code: 0, userInfo: nil)
        let networkRequestError = errorHandler.decodingError(error)
        XCTAssertEqual(networkRequestError, .decodingError(error.localizedDescription))
    }
}
