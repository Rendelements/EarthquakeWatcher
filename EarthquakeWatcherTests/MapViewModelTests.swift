//
//  MapViewModelTests.swift
//  EarthquakeWatcherTests
//
//  Created by Simon Withington on 2/12/18.
//  Copyright © 2018 RendElements. All rights reserved.
//

import Foundation

import XCTest
@testable import EarthquakeWatcher

class MapViewModelTests: XCTestCase {
    
    // Test class
    private var mapViewModel: MapViewModel!
    
    // Dependencies
    private var mapViewDelegateMock: MapViewControllerDelegate!
    private var earthquakeEventManagerMock: EarthquakeEventManager!
    
    override func setUp() {
        super.setUp()
        
        mapViewDelegateMock = MapViewDelegateMock()
        earthquakeEventManagerMock = EarthquakeEventManagerMock()
        
        mapViewModel = MapViewModel(delegate: mapViewDelegateMock, earthquakeEventManager: earthquakeEventManagerMock)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    
}

fileprivate class MapViewDelegateMock: MapViewControllerDelegate {
    
    func plotAnnotationsForEarthquakeEvents(_ events: [EarthquakeEvent], completionHandler completion: @escaping () -> Void) {}
    
    init() {}
}

fileprivate class EarthquakeEventManagerMock: EarthquakeEventManager {
    
    var cacheUpated: Bool = false
    
    var cachedEarthquakeEvents: [EarthquakeEvent] = []
    
    var focusEventIdx: Int? = nil
    
    func getAllPastDayEvents(withCompletionHandler completion: @escaping (APIClientResponse, [EarthquakeEvent]) -> Void) {
        
        completion(.successful, cachedEarthquakeEvents)
    }
    
    init() {
        
//        cachedEarthquakeEvents = [EarthquakeEvent()]
    }
}
