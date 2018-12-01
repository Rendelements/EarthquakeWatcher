//
//  EndpointConstants.swift
//  EarthquakeWatcher
//
//  Created by Simon Withington on 1/12/18.
//  Copyright © 2018 RendElements. All rights reserved.
//

import Foundation

struct EndpointConstant {
    
    enum EarthquakeTimeWindow: String {
        
        case allDay
        
        var path: String {
            return "\\/\(self.rawValue).geojson"
        }
    }

    private struct USGS {
        
        #if DEBUG
        static let base: String = "https://earthquake.usgs.gov" // We can swap out for a stub server if needed
        #else
        static let base: String = "https://earthquake.usgs.gov"
        #endif
    }
    
    private struct Earthquakes {
        
        static let earthquakes: String = "/earthquakes"
        static let feed: String = "/feed"
        static let version: String = "/v1.0"
        static let summary: String = "/summary"
        static let allDay: String = "/all_day.geojson"
    }
    
    static func getEarthquakePathForTimeWindow(_ timeWindow: EarthquakeTimeWindow) -> String {
        
        var address: String = USGS.base
        address += Earthquakes.earthquakes
        address += Earthquakes.feed
        address += Earthquakes.version
        address += Earthquakes.summary
        address += timeWindow.path
        
        return address
    }
    
    // In case we need to load a url header
    static func appHeader() -> [String: String] {
        
        return [:]
    }
}
