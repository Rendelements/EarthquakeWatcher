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
    
}

final class MapViewController: UIViewController, MapViewControllerDelegate {
    
    lazy var viewModel: MapViewModel = MapViewModel(delegate: self)
    
    var gmsMapView: GMSMapView? // Convenience
    
    override func loadView() {
        super.loadView()
        
        makeMapView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getAllEarthquakesPastDay()
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
