//
//  NetworkRequestError.swift
//  EventListDemo
//
//  Created by Maryia Bahlai
//

import Foundation

enum NetworkRequestError: LocalizedError, Equatable {
    case invalidRequest(_ error: String)
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case error4xx(_ code: Int)
    case serverError
    case error5xx(_ code: Int)
    case decodingError(_ error: String)
    case unknownError

    var errorDescription: String? {
        switch self {
        case .unauthorized:
            return "Please sign in to continue..."
        default:
            return "There seems to be a problem. Please contact support."
        }
    }
}
