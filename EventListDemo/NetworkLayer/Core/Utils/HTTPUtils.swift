//
//  HTTPUtils.swift
//  EventListDemo
//
//  Created by Maryia Bahlai
//

import Foundation

typealias Parameters = [String: String]

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum HTTPTask {
    case requestParameters(urlParameters: Parameters?)
}
