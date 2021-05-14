//
//  SeatGeekSUCombineApp.swift
//  SeatGeekSUCombine
//
//  Created by Satoru Ishii on 5/13/21.
//

import SwiftUI

@main
struct SeatGeekSUCombineApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = SearchEventsViewModel()
            SearchEventsView(viewModel: viewModel)
        }
    }
}
