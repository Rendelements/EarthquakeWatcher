//
//  ListViewModel.swift
//  EarthquakeWatcher
//
//  Created by Simon Withington on 30/11/18.
//  Copyright © 2018 RendElements. All rights reserved.
//

import Foundation

class ListViewModel {
    
    private var earthquakeEventManager: EarthquakeEventManager
    
    var eventCount: Int {
        return earthquakeEventManager.cachedEarthquakeEvents.count
    }
    
    init(earthquakeEventManager: EarthquakeEventManager = LocalEarthquakeEventManager.shared) {
        
        self.earthquakeEventManager = earthquakeEventManager
    }
    
    func getEventTextHeadingAtIndex(_ idx: Int) -> String {
        
        guard let event = getEventAtIndex(idx) else {
            return ""
        }
        
        let id = idx + 1
        
        let eventTime = event.date.full12HourString
        let magnitudeString = String(format: "%.1f", event.magnitude)
        
        return "\(id). \(eventTime) / magnitude: \(magnitudeString)"
    }
    
    func getEventTextDetailsAtIndex(_ idx: Int) -> String {
        
        guard let event = getEventAtIndex(idx),
            let eventLocation = event.location?.prettyPrinted else {
                return ""
        }
        
        return "\(eventLocation)"
    }
    
    func setEventFocus(_ idx: Int) {
        earthquakeEventManager.focusEventIdx = idx
    }
    
    func getAllPastDayEvents(withCompletionHandler completion: @escaping (APIClientResponse) -> Void) {
        
        earthquakeEventManager.getAllPastDayEvents{ (response, _) in 
            completion(response)
        }
    }
    
    private func getEventAtIndex(_ idx: Int) -> EarthquakeEvent? {
        
        if idx < eventCount - 1 {
            return earthquakeEventManager.cachedEarthquakeEvents[idx]
        } else {
            return nil
        }
    }
}
