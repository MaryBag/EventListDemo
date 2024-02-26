//
//  EventListDemoApp.swift
//  EventListDemo
//
//  Created by Maryia Bahlai
//

import SwiftUI

@main
struct EventListDemoApp: App {
    var body: some Scene {
        WindowGroup {
            EventListView(viewModel: EventListDemoAppResolver().resolve())
        }
    }
}
