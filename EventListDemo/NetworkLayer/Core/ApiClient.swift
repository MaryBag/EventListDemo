//
//  ApiClient.swift
//  EventListDemo
//
//  Created by Maryia Bahlai
//

import Foundation

protocol ApiClientInterface {
    func execute<EndPoint: EndPointInterface, Model: Decodable>(for route: EndPoint) async throws -> Model
}

final class ApiClient: ApiClientInterface {
    private var requestBuilder: RequestBuilderInterface
    private var requestExecutor: RequestExecutorInterface
    private var errorHandler: ErrorHandlerInterface
    
    init(_ requestBuilder: RequestBuilderInterface, _ requestExecutor: RequestExecutorInterface, _ errorHandler: ErrorHandlerInterface) {
        self.requestBuilder = requestBuilder
        self.requestExecutor = requestExecutor
        self.errorHandler = errorHandler
    }
    
    func execute<EndPoint: EndPointInterface, Model: Decodable>(for route: EndPoint) async throws -> Model {
        let request = requestBuilder.buildRequest(from: route)
        
        do {
            let (data, response) = try await requestExecutor.execute(for: request)
            
            if let error = errorHandler.httpError(response) {
                throw error
            }
           
            do {
                let decodedData = try JSONDecoder().decode(Model.self, from: data)
                return decodedData
            } catch {
                throw errorHandler.decodingError(error)
            }
        } catch {
            throw errorHandler.requestError(error)
        }
    }
}
