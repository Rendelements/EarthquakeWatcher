//
//  HTTPClient.swift
//  EarthquakeWatcher
//
//  Created by Simon Withington on 1/12/18.
//  Copyright © 2018 RendElements. All rights reserved.
//

import Foundation

class HTTPClient {
    
    enum HTTPMethod: String {
        
        case GET
        case POST
        case UPDATE
        case DELETE
    }
    
    let session: URLSession
    
    init(urlSession: URLSession? = nil) {
        
        if let urlSession = urlSession {
            self.session = urlSession
            return
        }
        
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        self.session = URLSession(configuration: config)
    }
}

extension HTTPClient {
    
    // NOTE: This is very basic GET request, we can have a special error handler as a param, maybe in future...
    
    func getRequest(_ urlRequest: String, 
                    withHeader requestHeader: Dictionary<String, String>? = nil,
                    completetionHandler: @escaping (_ requestWasSuccessful: Bool, _ requestStatusCode: Int?, _ requestData: Data?) -> Void) {
        
        guard let url = URL(string: urlRequest) else { 
            completetionHandler(false, nil, nil)
            return 
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        
        if let requestHeader = requestHeader {
            
            var headers = [String: String]()
            requestHeader.forEach { headers[$0] = $1 }
            request.allHTTPHeaderFields = headers
        }
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                completetionHandler(false, nil, nil)
                return
            } else {
                if response != nil {
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        let isSuccess = 200..<300 ~= httpResponse.statusCode
                        completetionHandler(isSuccess, httpResponse.statusCode, data)
                    } else {
                        completetionHandler(false, nil, nil)
                    }
                } else {
                    completetionHandler(false, nil, nil)
                }
            }
        }
        task.resume()
    }
}
