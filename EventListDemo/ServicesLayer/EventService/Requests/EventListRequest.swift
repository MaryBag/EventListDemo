//
//  EventListRequest.swift
//  EventListDemo
//
//  Created by Maryia Bahlai
//

import Foundation

//Doc:
//https://platform.seatgeek.com/#events

struct EventListRequest: EndPointInterface {
    var baseURL: URL
    var path: String?
    var httpMethod: HTTPMethod
    var task: HTTPTask
    var headers: Parameters?
    
    init(clientId: String) {
        baseURL = URL(string: "https://api.seatgeek.com")!
        path = "2/events"
        httpMethod = .get
        task = .requestParameters(urlParameters: ["client_id": clientId])
        headers = ["Accept": "application/json"]
    }
}
