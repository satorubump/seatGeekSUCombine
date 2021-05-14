//
//  EventsResponse.swift
//  SeatGeekSUCombine
//
//  Created by Satoru Ishii on 5/13/21.
//

import Foundation

///
///  Download Events Data Model
///
struct EventsResponse : Codable {
    /// Events Array
    let events : [Event]
    enum CodingKeys : String, CodingKey {
        case events
    }
    /// Event
    struct Event : Codable {
        let id : Int
        let title : String
        let datetime_local : String
        let performers : [Performer]
        let venue : Venue
        enum CodingKeys : String, CodingKey {
            case id
            case title
            case datetime_local
            case performers
            case venue
        }
        /// Performer
        struct Performer : Codable {
            let image : String
            enum CodingKeys : String, CodingKey {
                case image
            }
        }
        /// Venue
        struct Venue : Codable {
            let display_location : String
            enum CodingKeys : String, CodingKey {
                case display_location
            }
        }
    }
}
