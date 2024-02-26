//
//  Event.swift
//  EventListDemo
//
//  Created by Maryia Bahlai
//

import Foundation

struct Events: Codable, Equatable {
    var events: [Event]
}

struct Event: Codable, Identifiable, Equatable {
    static func == (lhs: Event, rhs: Event) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: Int
    var title: String?
    @DateFormatted<DayDateStrategy> var datetime_utc: Date?
    var venue: EventVenue?    
}
