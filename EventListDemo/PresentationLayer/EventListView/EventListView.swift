//
//  EventListView.swift
//  EventListDemo
//
//  Created by Maryia Bahlai
//

import SwiftUI

struct EventListView: View {
    @StateObject var viewModel: EventListViewModel
    
    var body: some View {
        contentView
        .task {
            await viewModel.onAppear()
        }
    }
    
    private var contentView: some View {
        List(viewModel.eventList, rowContent: { event in
            EventView(viewModel: EventViewModel(event))
        })
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
        }
    }
}


#Preview {
    EventListView(viewModel: EventListDemoAppResolver().resolve())
}
