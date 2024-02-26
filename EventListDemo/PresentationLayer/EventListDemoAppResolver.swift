//
//  EventListDemoAppResolver.swift
//  EventListDemo
//
//  Created by Maryia Bahlai
//

import Foundation

@MainActor
struct EventListDemoAppResolver {
    
    func resolve() -> EventListViewModel {
        EventListViewModel(eventService: resolve())
    }
    
    func resolve() -> EventServiceInterface {
        EventService(resolve())
    }
    
    func resolve() -> ApiClientInterface {
        ApiClient(resolve(), resolve(), resolve())
    }
    
    func resolve() -> RequestExecutorInterface {
        RequestExecutor()
    }
    
    func resolve() -> RequestBuilderInterface {
        RequestBuilder()
    }
    
    func resolve() -> ErrorHandlerInterface {
        ErrorHandler()
    }
}
