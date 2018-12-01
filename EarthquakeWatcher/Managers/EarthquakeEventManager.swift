//
//  EarthquakeEventManager.swift
//  EarthquakeWatcher
//
//  Created by Simon Withington on 1/12/18.
//  Copyright © 2018 RendElements. All rights reserved.
//

import Foundation
import CoreLocation

// NOTE: This is designed as a single source of truth for the earthquake events in the App

protocol EarthquakeEventManager {
    
    var cachedEarthquakeEvents: [EarthquakeEvent] { get }
    var focusEventIdx: Int? { get set }
    var focusCoordinate: CLLocationCoordinate2D? { get }
    
    func getAllPastDay(withCompletionHandler completion: @escaping (APIClientResponse, [EarthquakeEvent]) -> Void)
}

class LocalEarthquakeEventManager: EarthquakeEventManager {
    
    static let shared = LocalEarthquakeEventManager()
    
    var cachedEarthquakeEvents: [EarthquakeEvent] = []
    private let apiClient: APIClient
    
    var focusEventIdx: Int?
    
    var focusCoordinate: CLLocationCoordinate2D? {
        
        if let idx = focusEventIdx {
            return cachedEarthquakeEvents[idx].location
        } else {
            return nil
        }
    }
    
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
            
            let earthquakeEvents = features.map{ EarthquakeEvent(model: $0) }.sorted{ $0.magnitude > $1.magnitude }
            self?.cachedEarthquakeEvents = earthquakeEvents
            
            completion(response, earthquakeEvents)
        }
    }
}
