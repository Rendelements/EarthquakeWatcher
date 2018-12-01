//
//  ListViewModel.swift
//  EarthquakeWatcher
//
//  Created by Simon Withington on 30/11/18.
//  Copyright © 2018 RendElements. All rights reserved.
//

import Foundation

class ListViewModel {
    
    weak var viewDelegate: ListViewControllerDelegate?
    
    private let earthquakeEventManager: EarthquakeEventManager
    
    init(delegate: ListViewControllerDelegate,
         earthquakeEventManager: EarthquakeEventManager = LocalEarthquakeEventManager.shared) {
        
        self.viewDelegate = delegate
        self.earthquakeEventManager = earthquakeEventManager
    }    
}
