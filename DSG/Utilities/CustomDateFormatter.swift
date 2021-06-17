//
//  CustomDateFormatter.swift
//  DSG
//
//  Created by Prateek Juneja on 17/06/21.
//

import Foundation

class CustomDateFormatter {
    private class var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy h:mm a"
        return formatter
    }
    
    class func formatTheDate(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
