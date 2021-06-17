//
//  EventListViewModel.swift
//  DSG
//
//  Created by Prateek Juneja on 17/06/21.
//

import Foundation
import UIKit

class EventListViewModel: EventListViewModelListener {
    
    fileprivate var getEventService: GetEventService!
    fileprivate var listener: EventListViewControllerListener?
    var events = Events(events: [])
    
    init(listener:EventListViewControllerListener) {
        self.listener = listener
        self.getEventService = GetEventService()
        self.getEventWithSearchQuery(query: "")
    }
    
    func getEventWithSearchQuery(query: String) {
        self.getEventService.getEventWithSearchQuery(query: query) { (eventData) in
            self.events = eventData!
            self.listener?.getEventWithSearchQueryCallback(isSuccess: true, message: "")
        } failure: { (errorMessage) in
            self.listener?.getEventWithSearchQueryCallback(isSuccess: false, message: errorMessage)
        }
    }
    
    func pushToEventDetailsPage(event: Event, navigationController: UINavigationController?, viewController: EventListViewController) {
        let storyboard = BaseStoryboard(name: "Main")
        let eventDetailsViewController : EventDetailsViewController = storyboard.instantiateViewController(EventDetailsViewController.className)
        eventDetailsViewController.delegate = viewController
        eventDetailsViewController.eventDetailsViewModel = EventDetailsViewModel(event: event)
        navigationController?.pushViewController(eventDetailsViewController, animated: true)
    }
    
    func provideTheIndexOfEventInEventsArray(events: [Event], event: Event) -> Int? {
        if events.contains(event) {
            if let index = events.firstIndex(of: event), index >= 0 {
                return index
            } else {
                return nil
            }
        }
        return nil
    }
}
