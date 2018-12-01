//
//  MapViewController.swift
//  EarthquakeWatcher
//
//  Created by Simon Withington on 30/11/18.
//  Copyright © 2018 RendElements. All rights reserved.
//

import UIKit
import GoogleMaps

protocol MapViewControllerDelegate: class {
    
    func plotAnnotationsForEarthquakeEvents(_ events: [EarthquakeEvent])
}

final class MapViewController: UIViewController {
    
    lazy var viewModel: MapViewModel = MapViewModel(delegate: self)
    
    var allMarkers: [GMSMarker] = []
    var gmsMapView: GMSMapView? // Convenience
    
    override func loadView() {
        super.loadView()
        
        makeMapView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getAllEarthquakesPastDay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let focusEventIdx = viewModel.focusEventIdx {
            focusToAnnotationForEventIdx(focusEventIdx)
        }
    }
    
    private func makeMapView() {
        
        let gmsMapView = GMSMapView(frame: self.view.bounds)
        gmsMapView.delegate = self
        gmsMapView.isMyLocationEnabled = true
        gmsMapView.settings.myLocationButton = true
        
        self.view = gmsMapView
        self.gmsMapView = gmsMapView
    }
}

extension MapViewController: GMSMapViewDelegate {
    
    
}

extension MapViewController: MapViewControllerDelegate {
    
    func plotAnnotationsForEarthquakeEvents(_ events: [EarthquakeEvent]) {
        
        DispatchQueue.main.async { [weak self] in
            
            var bounds = GMSCoordinateBounds()
            
            for event in events {
                
                guard let coordinate = event.location,
                    let date = event.date else { continue }
                
                bounds = bounds.includingCoordinate(coordinate)
                self?.addMapAnnotation(forCoordinate: coordinate, date: date)
            }
            
            let cameraUpdate = GMSCameraUpdate.fit(bounds, withPadding: Constants.Mapping.cameraPadding)
            self?.gmsMapView?.animate(with: cameraUpdate)
        }
    }
    
    func focusToAnnotationForEventIdx(_ idx: Int) {
        
        guard idx < allMarkers.count + 1 else { return }
        
        let selectedMarker = allMarkers[idx]
        
        viewModel.resetFocusCoordinate()
        
        DispatchQueue.main.async { [weak self] in
            
            let cameraUpdate = GMSCameraUpdate.setTarget(selectedMarker.position, zoom: 12)
            self?.gmsMapView?.selectedMarker = selectedMarker
            self?.gmsMapView?.animate(with: cameraUpdate)
        }
    }
    
    func addMapAnnotation(forCoordinate coordinate: CLLocationCoordinate2D, date: Date) {
        
        let marker = GMSMarker(position: coordinate)
        marker.snippet = "\(coordinate.prettyPrinted)\n\(date.full12HourString)"
        marker.zIndex = 10
        marker.map = gmsMapView
        allMarkers.append(marker)
    }
    
    func clearMap() {
        
        allMarkers.removeAll()
        gmsMapView?.clear()
    }
}
