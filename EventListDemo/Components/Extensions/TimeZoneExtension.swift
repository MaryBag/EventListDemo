//
//  TimeZoneExtension.swift
//  EventListDemo
//
//  Created by Maryia Bahlai
//

import Foundation

extension TimeZone {
    static var est: TimeZone {
        return TimeZone(abbreviation: "EST") ?? .gmt
    }
}
