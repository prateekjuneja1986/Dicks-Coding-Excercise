//
//  ImageDownloader.swift
//  DSG
//
//  Created by Prateek Juneja on 17/06/21.
//

import Foundation
import Nuke
import UIKit

class ImageDownloader {
    
    public static let shared = ImageDownloader()
    private init() {}
    
    public func loadImage(imageUrl : URL?, imageView : UIImageView?) {
        if let loadingView = imageView {
            if let url = imageUrl {
                Nuke.loadImage(with: url, into: loadingView)
            }
        }
    }
}
