//
//  EarthquakeEvent.swift
//  EarthquakeWatcher
//
//  Created by Simon Withington on 1/12/18.
//  Copyright © 2018 RendElements. All rights reserved.
//

import Foundation
import CoreLocation

class EarthquakeEvent {
    
    var location: CLLocationCoordinate2D?
    var time: Date?
    var id: String?
    
    init(model: FeatureCollectionUSGS.Features) {
        
        if let lat = model.geometry?.coordinates[0].locationDegrees,
            let long = model.geometry?.coordinates[1].locationDegrees {
            self.location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        }
        
        if let time = model.properties?.time {
            self.time = Date(timeIntervalSince1970: TimeInterval(time))
        }
        
        self.id = model.id
    }
}
