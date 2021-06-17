//
//  GetEventService.swift
//  DSG
//
//  Created by Prateek Juneja on 17/06/21.
//

import Foundation

class GetEventService: NSObject {
    private let baseUrl = "https://api.seatgeek.com/2/events?client_id="
    private let clientId = "MjIyNDYxMTh8MTYyMzc4MTMwMC4zMDE1MzE"
    let networkManager: NetworkManager
    
    private lazy var decoder: JSONDecoder = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
    
    override init() {
        networkManager = NetworkManager.sharedInstance
        super.init()
    }
    
    func getEventWithSearchQuery(query: String, success: @escaping (_ responseData:Events?) -> Void,
                                 failure:@escaping (_ networkResponseFailureMessage: String) -> Void) {
        guard let eventRequestUrl = URL(string: "\(baseUrl)\(clientId)&q=\(query)") else {
            failure("Bad Url")
            return
        }
        self.networkManager.requestDataFromSerevr(requestUrl: eventRequestUrl) { (responseData) in
            self.parseGetEventResponse(responseData, success, failure)
        } failure: { (errorMessage) in
            failure(errorMessage)
        }
    }
    
    fileprivate func parseGetEventResponse(_ responseData: Data, _ success : @escaping(Events?) -> Void,_ failureMessage : @escaping(String) -> Void) {
        do {
            let getEventResponse = try decoder.decode(Events.self, from: responseData)
            let processedResponse = self.processTheResponseWithSavedFavoriteInfo(events: getEventResponse)
            success(processedResponse)
        } catch let error {
            print("Error", error)
            failureMessage(error.localizedDescription)
        }
    }
    
    func processTheResponseWithSavedFavoriteInfo(events: Events?) -> Events? {
        guard let savedFavoriteIds = UserDefaults.standard.getSavedEventIds() else {
            return events
        }
        if let eventData = events {
            let events = eventData.events.map { event -> Event? in
                let isFavorite = self.checkIfEventIsMarkedFavorite(event: event, savedItems: savedFavoriteIds)
                return self.updateEventModelIfItIsFavorite(event: event, isFavorite: isFavorite)
            }.compactMap { $0 }
            return Events(events: events)
        }
        
        return nil
    }
    
    func checkIfEventIsMarkedFavorite(event: Event, savedItems: [Int]) -> Bool {
        return savedItems.contains(event.id)
    }
    
    func updateEventModelIfItIsFavorite(event: Event, isFavorite: Bool) -> Event {
        var tempEvent = event
        tempEvent.isFavourite = isFavorite
        return tempEvent
    }
    
}
