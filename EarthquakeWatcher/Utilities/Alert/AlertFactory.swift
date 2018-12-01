//
//  AlertFactory.swift
//  EarthquakeWatcher
//
//  Created by Simon Withington on 2/12/18.
//  Copyright © 2018 RendElements. All rights reserved.
//

import UIKit

final class AlertFactory {
    
    static func alertController(title: String?, 
                                message: String?, 
                                style: UIAlertController.Style = .alert) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: style)
    }
    
    static func alertAction(title: String?, 
                            style: UIAlertAction.Style = .default, 
                            action: (() -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: title, style: style, handler: { _ in action?() })
    }
}
