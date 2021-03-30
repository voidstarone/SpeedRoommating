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
    
    @IBOutlet weak var pagingScrollView: TabbableScrollView!
    
    @IBOutlet weak var upcomingEventListView: UIView!
    @IBOutlet weak var archivedEventListView: UIView!
    @IBOutlet weak var optionsView: UIView!
    
    @IBOutlet weak var upcomingTab: SpeedRoommatingTabView!
    @IBOutlet weak var archivedTab: SpeedRoommatingTabView!
    @IBOutlet weak var optionsTab: SpeedRoommatingTabView!
    
    var tabController: TabController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let archivedEventsController = storyboard!.instantiateViewController(withIdentifier: "EventListTableViewController") as? EventListTableViewController else {
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

