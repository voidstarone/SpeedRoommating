//
//  ViewController.swift
//  SpeedRoommating
//
//  Created by Thomas Lee on 18/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import UIKit
import SpeedRoommatingEventRepository

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ep = SpeedRoommatingEventProvider()

        ep.preloadEventsOnOrAfter(date: Date()) {_ in }
        // Do any additional setup after loading the view.
    }
}

