//
//  EventListViewControllerProtocol.swift
//  DSG
//
//  Created by Prateek Juneja on 17/06/21.
//

import Foundation
import UIKit

protocol EventListViewControllerListener: class {
    func getEventWithSearchQueryCallback(isSuccess: Bool, message: String)
    
}

protocol EventListViewModelListener {
    func getEventWithSearchQuery(query: String)
    func pushToEventDetailsPage(event: Event, navigationController: UINavigationController?, viewController: EventListViewController)
    func provideTheIndexOfEventInEventsArray(events: [Event], event: Event) -> Int?
}
