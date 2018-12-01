//
//  CLLocationCoordinate2D+Extension.swift
//  EarthquakeWatcher
//
//  Created by Simon Withington on 1/12/18.
//  Copyright © 2018 RendElements. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    
    var prettyPrinted: String {
        return String(format: "latitude: %.3f, longitude: %.3f", self.latitude, self.longitude)
    }
}
