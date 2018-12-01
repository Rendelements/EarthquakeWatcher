//
//  MapViewModel.swift
//  EarthquakeWatcher
//
//  Created by Simon Withington on 30/11/18.
//  Copyright © 2018 RendElements. All rights reserved.
//

import Foundation
import CoreLocation

class MapViewModel {
    
    weak var viewDelegate: MapViewControllerDelegate?
    
    private var earthquakeEventManager: EarthquakeEventManager
    
    var focusEventIdx: Int? {
        return earthquakeEventManager.focusEventIdx
    }
    
    init(delegate: MapViewControllerDelegate,
        earthquakeEventManager: EarthquakeEventManager = LocalEarthquakeEventManager.shared) {
        
        self.viewDelegate = delegate
        self.earthquakeEventManager = earthquakeEventManager
    }
    
    func getAllEarthquakesPastDay(withCompletionHandler completion: @escaping (APIClientResponse, [EarthquakeEvent]) -> Void) {
        earthquakeEventManager.getAllPastDayEvents(withCompletionHandler: completion)
    }
    
    func checkEventCache(completionHandler completion: @escaping () -> Void) {
        
        if earthquakeEventManager.cacheUpated {
            
            earthquakeEventManager.cacheUpated = false
            
            viewDelegate?.plotAnnotationsForEarthquakeEvents(earthquakeEventManager.cachedEarthquakeEvents, 
                                                             completionHandler: completion)
        } else {
            completion()
        }
    }
    
    func resetFocusCoordinate() {
        earthquakeEventManager.focusEventIdx = nil
    }
}
