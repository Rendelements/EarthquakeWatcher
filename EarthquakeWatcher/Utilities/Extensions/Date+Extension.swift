//
//  Date+Extension.swift
//  EarthquakeWatcher
//
//  Created by Simon Withington on 1/12/18.
//  Copyright © 2018 RendElements. All rights reserved.
//

import Foundation

extension Date {
    
    var full12HourString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy, h:mm a"
        return dateFormatter.string(from: self)
    }
}
