//
//  EventAPIService.swift
//  EventListDemo
//
//  Created by Maryia Bahlai
//

import Foundation

protocol EventServiceInterface {
    func getEventList() async throws -> [Event]
}

final class EventService: EventServiceInterface {
    
    private let apiClient: ApiClientInterface
    
    init(_ apiClient: ApiClientInterface) {
        self.apiClient = apiClient
    }
        
    func getEventList() async throws -> [Event] {
        let request = EventListRequest(clientId: getClientId())
        let response: Events = try await apiClient.execute(for: request)
        return response.events
    }
}

private extension EventService {
    func getClientId() -> String {
        return "MjE3MTU3MjV8MTYxODQxMDMzNS44NzY4MDQ4"
    }
}
