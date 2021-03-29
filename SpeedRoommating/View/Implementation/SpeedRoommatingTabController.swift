//
//  EventListsTabBar.swift
//  SpeedRoommating
//
//  Created by Thomas Lee on 29/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation
import UIKit

class TabController  {
    
    var tabButtons: [SpeedRoommatingTabView] = []
    var scrollView: UIScrollView!
    var viewsToScrollTo: [UIView] = []
    
    init(tabButtons: [SpeedRoommatingTabView], scrollView: UIScrollView, viewsToScrollTo: [UIView]) {
        self.tabButtons = tabButtons
        self.scrollView = scrollView
        self.viewsToScrollTo = viewsToScrollTo
        setup()
    }
    
    @objc func buttonPress(sender: UIButton) {
        print("button \(sender.tag) pressed: \(sender)")
        
        guard let tabView = sender.superview as? SpeedRoommatingTabView else {
            return
        }
        
        let buttonIndex = tabButtons.firstIndex(of: tabView)!
        let viewToScrollTo = viewsToScrollTo[buttonIndex]

        scrollView.scrollRectToVisible(viewToScrollTo.frame, animated: true)
        
        for index in 0..<tabButtons.count {
            tabButtons[index].isSelected = (index == buttonIndex)
        }
    }
    
    func setup() {
        if tabButtons.count != viewsToScrollTo.count {
            return
        }
        for index in 0..<tabButtons.count {
            tabButtons[index].tag = index
            tabButtons[index].button.addTarget(self,
                                               action: #selector(buttonPress),
                                               for: .touchUpInside)
        }
    }
}
