//
//  BaseStoryboard.swift
//  DSG
//
//  Created by Prateek Juneja on 17/06/21.
//

import Foundation
import UIKit

public struct BaseStoryboard {
    
    fileprivate let name: String
    
    // init
    public init(name: String) {
        self.name = name
    }
    
    // This function will load storyborad by there name
    fileprivate func storyboard(_ name: String) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: Bundle.main)
    }
    
    // This function will load initial view controller from storyborad by storyboard name
    fileprivate func initialViewController<T>() -> T {
        let uiStoryboard = storyboard(name)
        return uiStoryboard.instantiateInitialViewController() as! T
    }
    
    // This function will load view controller by identifier name
    public func instantiateViewController<T>(_ viewControllerIdentifier: String) -> T {
        let uiStoryboard = storyboard(name)
        return uiStoryboard.instantiateViewController(withIdentifier: viewControllerIdentifier) as! T
    }
    
    // This function will initiate a view controller default viewcontroller class name will be passes as view controller idetifier
    public func instantiateViewController<T>() -> T {
        return instantiateViewController(String(describing: T.self))
    }
}
