//
//  MapViewModelTests.swift
//  EarthquakeWatcherTests
//
//  Created by Simon Withington on 2/12/18.
//  Copyright © 2018 RendElements. All rights reserved.
//

import Foundation

import XCTest
import CoreLocation

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
        
        mapViewModel = nil
        
        earthquakeEventManagerMock = nil
        mapViewDelegateMock = nil
        
        super.tearDown()
    }
    
    func testGetAllEarthquakesPastDay() {
        
        let closureExpectation = expectation(description: "Closure succeeds and returns")
        
        mapViewModel.getAllEarthquakesPastDay(withCompletionHandler: { (response, events) in
            
            XCTAssertTrue(response == .successful)
            XCTAssertTrue(events.count == 2)
            
            closureExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 1) { error in
            
            if let error = error {
                XCTFail("waitForExpectations errored: \(error)")
            }
        }
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
        
        cachedEarthquakeEvents = [EarthquakeEvent(location: CLLocationCoordinate2D(), date: Date(), id: "", magnitude: 1.0),
                                  EarthquakeEvent(location: CLLocationCoordinate2D(), date: Date(), id: "", magnitude: 2.0)]
    }
}
