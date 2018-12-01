//
//  ListViewController.swift
//  EarthquakeWatcher
//
//  Created by Simon Withington on 30/11/18.
//  Copyright © 2018 RendElements. All rights reserved.
//

import UIKit

protocol ListViewControllerDelegate: class {
    
    
}

final class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel: MapViewModel = ListViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

extension ListViewController: ListViewControllerDelegate {
    
    
}

