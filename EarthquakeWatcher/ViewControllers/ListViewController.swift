//
//  ListViewController.swift
//  EarthquakeWatcher
//
//  Created by Simon Withington on 30/11/18.
//  Copyright © 2018 RendElements. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel: ListViewModel = ListViewModel()
    
    var listRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        add(refreshControl: listRefreshControl, to: tableView)
    }

    private func setupTableView() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func add(refreshControl: UIRefreshControl, to scrollView: UIScrollView) {
        
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: UIControl.Event.valueChanged)
        scrollView.refreshControl = refreshControl
    }
    
    func endRefreshControl() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.Defaults.layoutRefreshDelay, execute: { [weak self] in
            
            self?.tableView.reloadData()
            self?.listRefreshControl.endRefreshing()
        })
    }
    
    @objc private func pullToRefresh() {
        
        viewModel.getAllPastDayEvents { [weak self] (response) in
            
            self?.endRefreshControl()
            
            switch response {
            case .successful:
                // Do nothing
                break
            case .decodeError:
                // Error modal
                break
            case .successfulEmpty:
                // Error modal
                break
            case .unkownError:
                // Error modal
                break
            }
        }
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
