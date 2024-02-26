//
//  ErrorHandler.swift
//  EventListDemo
//
//  Created by Maryia Bahlai
//

import Foundation

protocol ErrorHandlerInterface {
    func requestError(_ error: Error) -> NetworkRequestError
    func httpError(_ response: URLResponse) -> NetworkRequestError?
    func decodingError(_ error: Error) -> NetworkRequestError
}

struct ErrorHandler: ErrorHandlerInterface {
    func requestError(_ error: Error) -> NetworkRequestError {
        if let error = error as? NetworkRequestError {
            return error
        }
        return .invalidRequest(error.localizedDescription)
    }
    
    func httpError(_ response: URLResponse) -> NetworkRequestError? {
        guard let httpResponse = response as? HTTPURLResponse else {
            return .unknownError
        }
        let httpStatusCode = httpResponse.statusCode
        switch httpStatusCode {
        case 200...299: return nil
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 402, 405...499: return .error4xx(httpStatusCode)
        case 500: return .serverError
        case 501...599: return .error5xx(httpStatusCode)
        default: return .unknownError
        }
    }
    
    func decodingError(_ error: Error) -> NetworkRequestError {
        if let error = error as? NetworkRequestError {
            return error
        }
        return .decodingError(error.localizedDescription)
    }
}
