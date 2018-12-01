//
//  APIClient.swift
//  EarthquakeWatcher
//
//  Created by Simon Withington on 1/12/18.
//  Copyright © 2018 RendElements. All rights reserved.
//

import Foundation

enum APIClientResponse {
    
    case successful
    case decodeError
    case successfulEmpty
    case unkownError
}

class APIClient {
 
    static let shared = APIClient()

    private let httpClient: HTTPClient

    init(httpClient: HTTPClient = HTTPClient()) {
        self.httpClient = httpClient
    }
}

extension APIClient {
    
    func getAllDayFeatureCollection(withCompletionHandler completion: @escaping (APIClientResponse, FeatureCollectionUSGS?) -> Void) {
        
        let requestURL = EndpointConstant.getEarthquakePathForTimeWindow(.allDay)
        
        httpClient.getRequest(requestURL) { (successful: Bool, statusCode: Int?, data: Data?) in
            
            // request was succesful from HTTP side
            guard successful, statusCode == 200 else {
                //most likely unauthorized error -> Check data for specs -> Display alert dialog + allow retry
                completion(.unkownError, nil)
                return
            }
            
            guard let data = data else {
                // Empty data
                completion(.successfulEmpty, nil)
                return
            }
            
            //request was successful and it returned "normal" data
            do {
                let featureCollection = try JSONDecoder().decode(FeatureCollectionUSGS.self, from: data)
                completion(.successful, featureCollection)
            } catch let error {
                // Decoding error
                debugPrint(error.localizedDescription)
                completion(.decodeError, nil)
            }
        }
    }
}
