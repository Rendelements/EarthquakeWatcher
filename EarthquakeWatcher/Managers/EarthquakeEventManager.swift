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
    
    func getAllPastDay(withCompletionHandler completion: @escaping (APIClientResponse, [EarthquakeEvent]) -> Void)
}

class LocalEarthquakeEventManager: EarthquakeEventManager {
    
    static let shared = LocalEarthquakeEventManager()
    
    private var cachedEarthquakeEvents: [EarthquakeEvent] = []
    private let apiClient: APIClient
    
    init(apiClient: APIClient = APIClient()) {
        
        self.apiClient = apiClient
    }
    
    func getAllPastDay(withCompletionHandler completion: @escaping (APIClientResponse, [EarthquakeEvent]) -> Void) {
        
        apiClient.getAllEarthquakesPastDay { [weak self] (response, featureCollection) in
            
            guard response == .successful,
            let features = featureCollection?.features else {
                completion(response, [])
                return
            }
            
            let earthquakeEvents = features.map { EarthquakeEvent(model: $0) }
            self?.cachedEarthquakeEvents = earthquakeEvents
            
            completion(response, earthquakeEvents)
        }
    }
}
