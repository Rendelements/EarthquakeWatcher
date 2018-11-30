//
//  GoogleMapsManager.swift
//  EarthquakeWatcher
//
//  Created by Simon Withington on 30/11/18.
//  Copyright © 2018 RendElements. All rights reserved.
//

import Foundation
import GoogleMaps
import GooglePlaces

final class GoogleMapsManager {
    
    static let plistApiKey: String = "GOOGLE_API_KEY"
    
    class func configureForPlist(_ plistName: String) {
        
        if let path = Bundle.main.path(forResource: plistName, ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path),
            let apiKey = dict[plistApiKey] as? String {
            
            GMSServices.provideAPIKey(apiKey)
            GMSPlacesClient.provideAPIKey(apiKey)
        }
    }
}
