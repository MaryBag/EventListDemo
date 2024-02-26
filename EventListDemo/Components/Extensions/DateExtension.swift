//
//  DateExtension.swift
//  EventListDemo
//
//  Created by Maryia Bahlai
//

import Foundation

enum DateFormatType: String {
    case mmmmDDyyyy = "MMMM dd, yyyy"
    case hhmma = "hh:mm a"
    case yyyymmddThhmmss = "yyyy-MM-dd'T'HH:mm:ss"
}

extension Date {
    func getString(_ type: DateFormatType) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .gmt
        dateFormatter.dateFormat = type.rawValue
        return dateFormatter.string(from: self)
    }
    
    func convert(from timeZone: TimeZone, to destinationTimeZone: TimeZone) -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents(in: timeZone, from: self)
        components.timeZone = destinationTimeZone
        return calendar.date(from: components)!
    }
}
