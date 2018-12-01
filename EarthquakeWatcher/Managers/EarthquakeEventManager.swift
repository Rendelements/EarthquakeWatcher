//
//  EarthquakeEventManager.swift
//  EarthquakeWatcher
//
//  Created by Simon Withington on 1/12/18.
//  Copyright © 2018 RendElements. All rights reserved.
//

import Foundation

// NOTE: This is designed as a single source of truth for the earthquake events in the App

protocol EarthquakeEventManager {
    
    func getAllPastDay(withCompletionHandler completion: (APIClientResponse, [EarthquakeEvent]) -> Void)
}

class LocalEarthquakeEventManager: EarthquakeEventManager {
    
    static let shared = LocalEarthquakeEventManager()
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient = APIClient()) {
        
        self.apiClient = apiClient
    }
    
    func getAllPastDay(withCompletionHandler completion: (APIClientResponse, [EarthquakeEvent]) -> Void) {
        
        apiClient.getAllEarthquakesPastDay { (response, featureCollection) in
            
            
            
        }
    }
}
