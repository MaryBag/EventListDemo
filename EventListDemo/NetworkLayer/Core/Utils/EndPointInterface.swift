//
//  EndPointInterface.swift
//  EventListDemo
//
//  Created by Maryia Bahlai
//

import Foundation

protocol EndPointInterface {
    
    var baseURL: URL { get }
    var path: String? { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: Parameters? { get }
}
