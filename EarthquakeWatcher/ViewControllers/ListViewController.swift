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
    
    lazy var viewModel: ListViewModel = ListViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }

    private func setupTableView() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.eventCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ListCell.reuseIdentifier) 
            ?? UITableViewCell(style: .subtitle, reuseIdentifier: Constants.ListCell.reuseIdentifier)
        
        cell.textLabel?.text = viewModel.getEventTextHeadingAtIndex(indexPath.row)
        cell.detailTextLabel?.text = viewModel.getEventTextDetailsAtIndex(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        viewModel.setEventFocus(indexPath.row)
        tabBarController?.selectedIndex = 0
    }
}

extension ListViewController: ListViewControllerDelegate {
    
    
}

