//
//  SearchEventsViewModel.swift
//  SeatGeekSUCombine
//
//  Created by Satoru Ishii on 5/13/21.
//

import Foundation
import SwiftUI
import Combine

///
///  Search Events View Model : Observed from SearchEventsView and Update the fetch result data in ASyncronizing
///
class SearchEventsViewModel : ObservableObject {
    /// Observed events data
    @Published var eventsResponse : EventsResponse?
    @Published var isUpdate = false
    
    /// Events fetcher class
    let seatGeekEventsAPI = SeatGeekEventsFetcher()
    
    /// Any cancellable Combine subscribe data
    private var disposables = Set<AnyCancellable>()

    ///  Call Fetcher Events API, Get Publiser & Subscribing the Events Data
    ///
    ///  Parameters:
    ///    paramA:  event: query key for events fetcher
    ///
    func searchEvents(event: String) -> Void {
        ///
        seatGeekEventsAPI.fetchEvents(event: event)
            /// receive on Main Thread
            .receive(on: DispatchQueue.main)
            /// sink data
            .sink(
                /// Get the failure / success
                receiveCompletion: { [weak self] value in
                    guard let self = self else { print("sink guard nil"); return }
                    switch value {
                    /// error
                    case .failure:
                        self.eventsResponse = nil
                    /// success
                    case .finished:
                        break
                    }
                },
                /// receive response data
                receiveValue: { [weak self] eventsResponse in
                    self!.eventsResponse = eventsResponse
                })
            .store(in: &disposables)
    }
    ///  Return If the Event is Favorite
    ///
    ///  Prameters:
    ///    paramA:  id: Event Identifier
    ///  Return: If it is favorite
    ///
    func isFavorite(id: Int) -> Bool {
        //self.isUpdate += 1
        if let favors = UserDefaults.standard.array(forKey: "favorites") {
            let favorites = favors as! [Int]
            return favorites.contains(id)
        }
        else {
            return false
        }
    }
}
