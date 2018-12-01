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
    private var earthquakeEvents: [EarthquakeEvent] = []
    
    init(delegate: MapViewControllerDelegate,
        earthquakeEventManager: EarthquakeEventManager = LocalEarthquakeEventManager.shared) {
        
        self.viewDelegate = delegate
        self.earthquakeEventManager = earthquakeEventManager
    }
    
    func getAllEarthquakesPastDay() {
        
        earthquakeEventManager.getAllPastDay { [weak self] (response, earthquakeEvents) in
            
            switch response {
            case .successful:
                
                
                break
            case .decodeError:
                
                
                break
            case .successfulEmpty:
                self?.earthquakeEvents.removeAll()
                break
            case .unkownError:
                
                
                break
            }
        }
    }
}
