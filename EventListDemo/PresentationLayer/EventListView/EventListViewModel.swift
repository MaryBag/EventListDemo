//
//  EventListViewModel.swift
//  EventListDemo
//
//  Created by Maryia Bahlai
//

import Foundation

@MainActor
final class EventListViewModel: ObservableObject {
    @Published var eventList: [Event] = []
    @Published var isLoading: Bool = false
    
    private let eventService: EventServiceInterface
    
    init(eventService: EventServiceInterface) {
        self.eventService = eventService
    }
    
    func onAppear() async {
        isLoading = true
        await fetchEventList()
        isLoading = false
    }
}

private extension EventListViewModel {
    func fetchEventList() async {
        do {
            eventList = try await eventService.getEventList()
        } catch {
            print(error.localizedDescription)
        }
    }
}
