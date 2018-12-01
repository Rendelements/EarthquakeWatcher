//
//  Constants.swift
//  EarthquakeWatcher
//
//  Created by Simon Withington on 30/11/18.
//  Copyright © 2018 RendElements. All rights reserved.
//

import Foundation
import CoreGraphics

struct Constants {
    
    struct General {
        
        static let infoPlistName: String = "Info"
        static let googlePlistName: String = "EarthquakeWatcherGoogleInfo"
    }
    
    struct Date {
        
        static let iso8601Format = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        static let iso8601FormatTruncated = "yyyy-MM-dd'T'HH:mm:'00.000'XXXXX"
        static let iso8601FormatTime = "HH:mm:ss"
    }
    
    struct Mapping {
        
        static let cameraPadding: CGFloat = 50.0
    }
    
    struct ListCell {
        
        static let reuseIdentifier: String = "CELL"
    }
    
    struct Defaults {
        
        static let layoutRefreshDelay: Double = 0.25
    }
}
