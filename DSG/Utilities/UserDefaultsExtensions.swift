//
//  UserDefaultsExtensions.swift
//  DSG
//
//  Created by Prateek Juneja on 17/06/21.
//

import Foundation

extension UserDefaults {
    func getSavedEventIds() -> [Int]? {
        return self.object(forKey: "eventIds") as? [Int]
    }
    
    func saveEventId(eventId : Int) {
        if var savedIds = getSavedEventIds(), savedIds.count > 0 {
            savedIds.append(eventId)
            self.saveEventIds(eventIds: savedIds)
        } else {
            self.saveEventIds(eventIds: [eventId])
        }
    }
    
    func saveEventIds(eventIds : [Int]) {
        self.set(eventIds, forKey: "eventIds")
        self.synchronize()
    }
}
