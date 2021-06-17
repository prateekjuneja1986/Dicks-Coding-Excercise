//
//  EventDetailsViewControllerProtocol.swift
//  DSG
//
//  Created by Prateek Juneja on 17/06/21.
//

import Foundation

protocol EventDetailsViewControllerDelegate: class {
    func didUpdateFavorite(event: Event)
}

protocol EventDetailsViewModelListener {
    func updateFavoriteInLocalDataBase(event: Event, isFavorite: Bool)
}
