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
    
    func plotAnnotationsForEarthquakeEvents(_ events: [EarthquakeEvent], completionHandler completion: @escaping () -> Void)
}

final class MapViewController: UIViewController {
    
    lazy var viewModel: MapViewModel = MapViewModel(delegate: self)
    lazy var alertManager: AlertManager = AlertManager(delegate: self)
    
    var allMarkers: [GMSMarker] = []
    var gmsMapView: GMSMapView? // Convenience
    
    override func loadView() {
        super.loadView()
        
        makeMapView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllEarthquakesPastDay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.checkEventCache { [weak self] in
            
            guard let strongSelf = self else { return }
            
            if let focusEventIdx = strongSelf.viewModel.focusEventIdx {
                strongSelf.focusToAnnotationForEventIdx(focusEventIdx)
            }
        }
    }
    
    private func makeMapView() {
        
        let gmsMapView = GMSMapView(frame: self.view.bounds)
        
        // Not needed, but could be used in future determine for example how far away from an earthquake a user is...
//        gmsMapView.isMyLocationEnabled = true
//        gmsMapView.settings.myLocationButton = true
        
        self.view = gmsMapView
        self.gmsMapView = gmsMapView
    }
    
    private func getAllEarthquakesPastDay() {
        
        viewModel.getAllEarthquakesPastDay { [weak self] (response, earthquakeEvents) in
            
            switch response {
            case .successful:
                self?.plotAnnotationsForEarthquakeEvents(earthquakeEvents, completionHandler: {}) 
            case .decodeError:
                self?.alertManager.presentDecodeError()
            case .successfulEmpty:
                self?.alertManager.presentEmptyError()
            case .unkownError:
                self?.alertManager.presentUnknownError()
            }
        }
    }
}

extension MapViewController: MapViewControllerDelegate {
    
    func plotAnnotationsForEarthquakeEvents(_ events: [EarthquakeEvent], completionHandler completion: @escaping () -> Void) {
        
        DispatchQueue.main.async { [weak self] in
            
            self?.clearMap()
            
            var bounds = GMSCoordinateBounds()
            
            for event in events {
                
                guard let coordinate = event.location,
                    let date = event.date else { continue }
                
                bounds = bounds.includingCoordinate(coordinate)
                self?.addMapAnnotation(forCoordinate: coordinate, date: date, magnitude: event.magnitude)
            }
            
            let cameraUpdate = GMSCameraUpdate.fit(bounds, withPadding: Constants.Mapping.cameraPadding)
            self?.gmsMapView?.animate(with: cameraUpdate)
            completion()
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
    
    func addMapAnnotation(forCoordinate coordinate: CLLocationCoordinate2D, 
                          date: Date, magnitude: Double) {
        
        let magnitudeString = String(format: "%.1f", magnitude)
        
        let marker = GMSMarker(position: coordinate)
        // TODO colour code the annotation to magnitude
        marker.snippet = "\(date.full12HourString), mag: \(magnitudeString)\n\(coordinate.prettyPrinted)"
        marker.map = gmsMapView
        allMarkers.append(marker)
    }
    
    func clearMap() {
        
        allMarkers.removeAll()
        gmsMapView?.clear()
    }
}
