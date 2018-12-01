//
//  MapViewModel.swift
//  EarthquakeWatcher
//
//  Created by Simon Withington on 30/11/18.
//  Copyright © 2018 RendElements. All rights reserved.
//

import Foundation

class MapViewModel {
    
    weak var viewDelegate: MapViewControllerDelegate?
    
    private let earthquakeEventManager: EarthquakeEventManager
    var earthquakeEvents: [EarthquakeEvent] = []
    
    init(delegate: MapViewControllerDelegate,
        earthquakeEventManager: EarthquakeEventManager = LocalEarthquakeEventManager.shared) {
        
        self.viewDelegate = delegate
        self.earthquakeEventManager = earthquakeEventManager
    }
    
    func getAllEarthquakesPastDay() {
        
        earthquakeEventManager.getAllPastDay { [weak self] (response, earthquakeEvents) in
            
            switch response {
            case .successful:
                self?.earthquakeEvents = earthquakeEvents
                self?.viewDelegate?.plotAnnotationsForEarthquakeEvents(earthquakeEvents)
            case .decodeError:
                
                
                break
            case .successfulEmpty:
                self?.earthquakeEvents.removeAll()
                
                // Modal
                break
            case .unkownError:
                
                
                break
            }
        }
    }
}
