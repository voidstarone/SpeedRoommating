//
//  ViewController.swift
//  SpeedRoommating
//
//  Created by Thomas Lee on 18/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import UIKit
import SpeedRoommatingEventRepository

class EventListsViewController: UIViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBOutlet weak var titleBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pagingScrollView: NotifyingScrollView!
    
    @IBOutlet weak var upcomingEventListView: UIView!
    @IBOutlet weak var archivedEventListView: UIView!
    @IBOutlet weak var optionsView: UIView!
    
    @IBOutlet weak var upcomingTab: SpeedRoommatingTabView!
    @IBOutlet weak var archivedTab: SpeedRoommatingTabView!
    @IBOutlet weak var optionsTab: SpeedRoommatingTabView!
    
    var tabController: TabController!
    
    private func setupAccessibility() {
        upcomingTab.isAccessibilityElement = true
        upcomingTab.accessibilityIdentifier = "main_tab_upcoming"
        upcomingTab.accessibilityLabel = "Upcoming"
        upcomingTab.accessibilityHint = "View future events"
        
        archivedTab.isAccessibilityElement = true
        archivedTab.accessibilityIdentifier = "main_tab_archived"
        archivedTab.accessibilityLabel = "Archived"
        archivedTab.accessibilityHint = "View previous events"
        
        optionsTab.isAccessibilityElement = true
        optionsTab.accessibilityIdentifier = "main_tab_options"
        optionsTab.accessibilityLabel = "Options"
        optionsTab.accessibilityHint = "Adjust app settings"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAccessibility()
        guard let archivedEventsController = storyboard!.instantiateViewController(
            withIdentifier: "EventListTableViewController") as? EventListTableViewController else {
            return
        }
        archivedEventsController.eventsDataSource.whichEventsToShow = EventsToShow.past

        addChild(archivedEventsController)
        archivedEventsController.view.translatesAutoresizingMaskIntoConstraints = false

        archivedEventListView.addSubview(archivedEventsController.view)
        NSLayoutConstraint.activate([
            archivedEventsController.view.leadingAnchor.constraint(equalTo: archivedEventListView.leadingAnchor, constant: 0),
            archivedEventsController.view.trailingAnchor.constraint(equalTo: archivedEventListView.trailingAnchor, constant: 0),
            archivedEventsController.view.topAnchor.constraint(equalTo: archivedEventListView.topAnchor, constant: 0),
            archivedEventsController.view.bottomAnchor.constraint(equalTo: archivedEventListView.bottomAnchor, constant: 0)
        ])
        let buttons = [upcomingTab, archivedTab, optionsTab]
        let views = [upcomingEventListView, archivedEventListView, optionsView]
        tabController = TabController(tabButtons: buttons as! [SpeedRoommatingTabView],
                                      scrollView: pagingScrollView,
                                      viewsToScrollTo: views as! [UIView])
    }
}

