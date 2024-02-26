//
//  EventViewModel.swift
//  EventListDemo
//
//  Created by Maryia Bahlai
//

import Foundation

final class EventViewModel: ObservableObject {
    private var event: Event
    
    @Published var title: String
    @Published var location: String?
    @Published var date: String?
    @Published var time: String?
    
    init(_ event: Event) {
        self.event = event
        self.title = event.title ?? ""
        self.location = event.venue?.display_location
        self.date = event.datetime_utc?.convert(from: .gmt, to: getTimeZone()).getString(.mmmmDDyyyy)
        self.time = event.datetime_utc?.convert(from: .gmt, to: getTimeZone()).getString(.hhmma)
    }
}

private extension EventViewModel {
    func getTimeZone() -> TimeZone {
        guard let identifier = event.venue?.timezone else { return TimeZone.est }
        return TimeZone(identifier: identifier) ?? TimeZone.est
    }
}
