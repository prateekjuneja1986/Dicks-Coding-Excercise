//
//  NSObjectExtension.swift
//  DSG
//
//  Created by Prateek Juneja on 17/06/21.
//

import Foundation

public extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
