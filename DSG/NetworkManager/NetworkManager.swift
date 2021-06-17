//
//  NetworkManager.swift
//  DSG
//
//  Created by Prateek Juneja on 17/06/21.
//

import Foundation

class NetworkManager {
    
    class var sharedInstance: NetworkManager {
        struct Singelton {
            static var instance = NetworkManager()
        }
        return Singelton.instance
    }
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    func requestDataFromSerevr(requestUrl:URL, success: @escaping (_ responseData:Data) -> Void,
                               failure:@escaping (_ networkResponseFailureMessage: String) -> Void) {
        dataTask?.cancel()
        dataTask = defaultSession.dataTask(with: requestUrl) { [weak self] responseData, urlResponse, responseError in
            defer {
                self?.dataTask = nil
            }
            
            if let error = responseError {
                failure(error.localizedDescription)
            } else if
                let data = responseData,
                let response = urlResponse as? HTTPURLResponse,
                response.statusCode == 200 {
                success(data)
            } else {
                failure("Some thing went wrong")
            }
        }
        dataTask?.resume()
    }
    
}
