//
//  EventView.swift
//  EventListDemo
//
//  Created by Maryia Bahlai
//

import SwiftUI

struct EventView: View {
    @ObservedObject var viewModel: EventViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.title)
                .font(.headline)
                .fontWeight(.bold)
            if let location = viewModel.location {
                Text(location)
                    .font(.body)
            }
            if let date = viewModel.date {
                Text(date)
                    .font(.footnote)
            }
            if let time = viewModel.time {
                Text(time)
                    .font(.footnote)
            }
        }
    }
}

#Preview {
    EventView(viewModel: EventViewModel(Event(id: 0, title: "Test", datetime_utc: Date(), venue: nil)))
}
