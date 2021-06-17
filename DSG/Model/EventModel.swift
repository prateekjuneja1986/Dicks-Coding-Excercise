//
//  EventModel.swift
//  DSG
//
//  Created by Prateek Juneja on 17/06/21.
//

import Foundation

// MARK: - Events
struct Events: Codable {
    let events: [Event]
    
    enum CodingKeys: String, CodingKey {
        case events
    }
}

// MARK: - Event
struct Event: Codable, Equatable {
    let id: Int
    let datetimeUTC: Date
    let venue: Venue
    let title: String
    let performers: [Performer]?
    var isFavourite = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case datetimeUTC = "datetime_utc"
        case venue
        case performers
    }
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Performer
struct Performer: Codable {
    let image: String?
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case image, id
    }
}

// MARK: - Venue
struct Venue: Codable {
    let displayLocation: String
    
    enum CodingKeys: String, CodingKey {
        case displayLocation = "display_location"
    }
}
