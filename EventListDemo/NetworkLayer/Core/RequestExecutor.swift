//
//  RequestExecutor.swift
//  EventListDemo
//
//  Created by Maryia Bahlai
//

import Foundation

protocol RequestExecutorInterface {
    func execute(for request: URLRequest) async throws -> (Data, URLResponse)
}

final class RequestExecutor: RequestExecutorInterface {
    private var urlSession: URLSession
    
    init() {
        urlSession = URLSession(configuration: .default)
    }
    
    func execute(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await urlSession.data(for: request)
    }
}
