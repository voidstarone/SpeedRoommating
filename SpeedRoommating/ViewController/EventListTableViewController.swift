//
//  EventListTableViewController.swift
//  SpeedRoommating
//
//  Created by Thomas Lee on 20/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import UIKit

class EventListTableViewController: UITableViewController {
    
    let eventsDataSource: IEventTableViewDataSource = EventTableViewDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = eventsDataSource
        tableView.delegate = eventsDataSource
        eventsDataSource.controlledTableView = self.tableView
        tableView.estimatedRowHeight = 210
        eventsDataSource.fetchEventsFromEventProvider {
            _ in
        }
    }
    
    private func isErrorState() {
        return
    }
}
