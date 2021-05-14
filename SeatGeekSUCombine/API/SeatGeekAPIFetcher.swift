//
//  SeatGeekAPIFetcher.swift
//  SeatGeekSUCombine
//
//  Created by Satoru Ishii on 5/13/21.
//

import Foundation
import Combine

///  API Error
///
enum APIError: Error {
    case network(description: String)
    case decoding(description: String)
}
///
///  SeatGeek Events Fetchable Protocol
///
/// - Functions:
///   - fetchAnimeList(title: String) return success; EventsResponse, fail: APIError
///
protocol SeatGeekEventsFetchable {
    func fetchEvents(event: String) -> AnyPublisher<EventsResponse, APIError>
}
///
///  SeatGeek Events Fetcher
///
class SeatGeekEventsFetcher : SeatGeekEventsFetchable {
    ///
    /// Fetch Events with event from SeatGeek API
    ///
    /// - Parameters:
    ///   - paramA: event key for query
    ///
    /// - Returns: AnyPublisher <Success : EventsResponse Publish  /  Fail :  APIError>
    ///
    func fetchEvents(event: String) -> AnyPublisher<EventsResponse, APIError> {
            let urlComponents = self.makeFetchEventsRequestUrl(event: event)
            return publishFetcher(components: urlComponents)
    }
    ///
    /// Create the Fetch Events Request URL
    ///
    /// - Parameters:
    ///   - paramA: Events query key - String
    /// - Returns: URLComponents -- URL Request
    ///
    private func makeFetchEventsRequestUrl(event: String) -> URLComponents {
        var urlComp = URLComponents()
        urlComp.scheme = Constants.Scheme
        urlComp.host = Constants.Host
        urlComp.path = Constants.Path
        
        urlComp.queryItems = [
            URLQueryItem(name: Constants.Client_Id, value: Constants.ClientId),
            URLQueryItem(name: Constants.Q, value: event),
        ]
        return urlComp
    }
    
    ///
    /// Private Connect SeatGeek API, Downloading and Publish the Events Data (Combine)
    ///
    /// - Parameters:
    ///  - paramA: components: URLCompnents
    ///
    /// - Returns: Any Publisher <Success: EventsResponse Publsh, Fail : APIError>
    ///
    private func publishFetcher(components: URLComponents) -> AnyPublisher<EventsResponse, APIError> {
        guard let url = components.url else {
            let error = APIError.network(description: "Can't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
          .mapError { error in
            .network(description: error.localizedDescription)
          }
          .flatMap(maxPublishers: .max(1)) { pair in
                self.decode(pair.data)
          }
          .eraseToAnyPublisher()
    }
    
    ///
    /// Decode json data to EventsResponse codable struct data
    ///
    /// - Parameters:
    ///   - paramA: download json data
    /// - Returns: Any Publish <decode success: EventsResponse Publish, fail: APIError>
    ///
    private func decode(_ data: Data) -> AnyPublisher<EventsResponse, APIError> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return Just(data)
            .decode(type: EventsResponse.self, decoder: decoder)
            .print()
            .mapError { error in
                .decoding(description: error.localizedDescription)
            }
          .eraseToAnyPublisher()
    }
}
