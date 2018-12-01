//
//  FeatureCollectionUSGS.swift
//  EarthquakeWatcher
//
//  Created by Simon Withington on 1/12/18.
//  Copyright © 2018 RendElements. All rights reserved.
//

import Foundation

struct FeatureCollectionUSGS: Decodable {
    
    var type: String?
    var metadata: MetaData?
    var features: [Features]?
    var bbox: [Decimal]

    struct MetaData: Decodable {
    
        var generated: Int?
        var url: String?
        var title: String?
        var api: String?
        var count: Int?
        var status: Int?
    }
    
    struct Features: Decodable {
    
        var type: String?
        var properties: Properties?
        var geometry: Geometry?
        var id: String?
        
        struct Properties: Decodable {
            
            var mag: Decimal?
            var time: Int?
        }
        
        struct Geometry: Decodable {
            
            var type: String?
            var coordinates: [Decimal]
        }
    }
}
