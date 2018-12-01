//
//  AlertManager.swift
//  EarthquakeWatcher
//
//  Created by Simon Withington on 2/12/18.
//  Copyright © 2018 RendElements. All rights reserved.
//

import UIKit

final class AlertManager {
    
    weak var delegate: UIViewController?
    
    init(delegate: UIViewController) {
        self.delegate = delegate
    }
    
    func presentDecodeError() {
        
        let alert = AlertFactory.alertController(title: "API Decoding Error!", 
                                                 message: "Cannot decode the USGS API JSON", 
                                                 style: .alert)
        alert.addAction(AlertFactory.alertAction(title: "OK", style: .cancel))
        
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.present(alert, animated: true)
        }
    }
    
    func presentEmptyError() {
        
        let alert = AlertFactory.alertController(title: "USGS API Empty..", 
                                                 message: "Please try again later", 
                                                 style: .alert)
        alert.addAction(AlertFactory.alertAction(title: "OK", style: .cancel))
        
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.present(alert, animated: true)
        }
    }
    
    func presentUnknownError() {
        
        let alert = AlertFactory.alertController(title: "Whoops!", 
                                                 message: "Something has broken... Sorry.", 
                                                 style: .alert)
        alert.addAction(AlertFactory.alertAction(title: "OK", style: .cancel))
        
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.present(alert, animated: true)
        }
    }
}
