//
//  EarthquakeEvent.swift
//  EarthquakeWatcher
//
//  Created by Simon Withington on 1/12/18.
//  Copyright © 2018 RendElements. All rights reserved.
//

import Foundation
import CoreLocation

struct EarthquakeEvent {
    
    var location: CLLocationCoordinate2D?
    var date: Date
    var id: String?
    var magnitude: Double
    
    init(model: FeatureCollectionUSGS.Features) {
        
        if let lat = model.geometry?.coordinates[1].locationDegrees,
            let long = model.geometry?.coordinates[0].locationDegrees {
            self.location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        }
        
        if let time = model.properties?.time {
            self.date = Date(timeIntervalSince1970: TimeInterval(time) * Constants.Defaults.milliseconds)
        } else {
            self.date = Date(timeIntervalSince1970: 0)
        }
        
        self.id = model.id
        
        if let magnitude = model.properties?.mag?.doubleValue {
            self.magnitude = magnitude
        } else {
            self.magnitude = 0.0 
        }
    }
    
    init(location: CLLocationCoordinate2D?, date: Date, id: String?, magnitude: Double) {
        
        self.location = location
        self.date = date
        self.id = id
        self.magnitude = magnitude
    }
}
