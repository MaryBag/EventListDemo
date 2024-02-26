//
//  DayDateStrategy.swift
//  EventListDemo
//
//  Created by Maryia Bahlai
//

import Foundation

public protocol DateValueCodableStrategy {
    associatedtype RawValue: Codable

    static func decode(_ value: RawValue?) throws -> Date?
    static func encode(_ date: Date?) -> RawValue?
}

@propertyWrapper struct DateFormatted<T: DateValueCodableStrategy>: Codable {
    private let value: T.RawValue?
    var wrappedValue: Date?
    
    init(wrappedValue: Date?) {
        self.wrappedValue = wrappedValue
        self.value = T.encode(wrappedValue)
    }
    
    init(from decoder: Decoder) throws {
        self.value = try T.RawValue(from: decoder)
        self.wrappedValue = try T.decode(value)
    }
    
    func encode(to encoder: Encoder) throws {
        try value?.encode(to: encoder)
    }
}

struct DayDateStrategy: DateValueCodableStrategy {
    static func decode(_ value: String?) throws -> Date? {
        guard let value = value else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatType.yyyymmddThhmmss.rawValue
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .gmt
        return formatter.date(from: value)
    }
    
    static func encode(_ date: Date?) -> String? {
        guard let date = date else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatType.yyyymmddThhmmss.rawValue
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .gmt
        return formatter.string(from: date)
    }
}
