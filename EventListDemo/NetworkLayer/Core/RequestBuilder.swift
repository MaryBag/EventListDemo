//
//  RequestBuilder.swift
//  EventListDemo
//
//  Created by Maryia Bahlai
//

import Foundation

protocol RequestBuilderInterface {
    func buildRequest<EndPoint: EndPointInterface>(from route: EndPoint) -> URLRequest
}

struct RequestBuilder: RequestBuilderInterface {
    
    func buildRequest<EndPoint: EndPointInterface>(from route: EndPoint) -> URLRequest {
        var url = route.baseURL
        if let path = route.path {
            url = url.appendingPathComponent(path)
        }
        var request = URLRequest(url: url,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 60.0)
        
        request.httpMethod = route.httpMethod.rawValue
        
        route.headers?.forEach({
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        })
        
        switch route.task {
        case .requestParameters(let urlParameters):
            let urlQueryItems = urlParameters?.map({ URLQueryItem(name: $0.key, value: $0.value) }) ?? []
            if !urlQueryItems.isEmpty {
                request.url?.append(queryItems: urlQueryItems)
            }
        }
        
        return request
    }
}


