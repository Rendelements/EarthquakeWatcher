//
//  Decimal+Extension.swift
//  EarthquakeWatcher
//
//  Created by Simon Withington on 1/12/18.
//  Copyright © 2018 RendElements. All rights reserved.
//

import Foundation
import CoreLocation

extension Decimal {
    
    var degrees: CLLocationDegrees {
        return CLLocationDegrees(self.doubleValue)
    }
    
    var doubleValue: Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
