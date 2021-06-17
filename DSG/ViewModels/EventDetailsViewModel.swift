//
//  EventDetailsViewModel.swift
//  DSG
//
//  Created by Prateek Juneja on 17/06/21.
//

import Foundation

class EventDetailsViewModel: EventDetailsViewModelListener {
    
    var event: Event
    
    init(event: Event) {
        self.event = event
    }
    
    func updateFavoriteInLocalDataBase(event: Event, isFavorite: Bool) {
        var tempEvent = event
        if var savedIds = UserDefaults.standard.getSavedEventIds(), savedIds.count > 0 {
            if savedIds.contains(event.id) && !isFavorite {
                if let index = savedIds.firstIndex(of: event.id), index >= 0 {
                    savedIds.remove(at: index)
                    UserDefaults.standard.saveEventIds(eventIds: savedIds)
                    tempEvent.isFavourite = isFavorite
                }
            } else if isFavorite && !savedIds.contains(event.id) {
                UserDefaults.standard.saveEventId(eventId: event.id)
                tempEvent.isFavourite = isFavorite
            }
        } else if isFavorite {
            UserDefaults.standard.saveEventId(eventId: event.id)
            tempEvent.isFavourite = isFavorite
        }
        self.event = tempEvent
    }
    
}
