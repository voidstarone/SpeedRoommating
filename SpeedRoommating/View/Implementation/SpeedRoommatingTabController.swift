//
//  EventListsTabBar.swift
//  SpeedRoommating
//
//  Created by Thomas Lee on 29/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation
import UIKit

class TabController : NSObject, TabbableScrollViewDelegate {
    
    var tabButtons: [SpeedRoommatingTabView] = []
    var scrollView: TabbableScrollView!
    var viewsToScrollTo: [UIView] = []
    
    init(tabButtons: [SpeedRoommatingTabView], scrollView: TabbableScrollView, viewsToScrollTo: [UIView]) {
        super.init()
        self.tabButtons = tabButtons
        self.scrollView = scrollView
        self.viewsToScrollTo = viewsToScrollTo
        setup()
    }
    
    @objc func buttonPress(sender: UIButton) {
        guard let tabView = sender.superview as? SpeedRoommatingTabView else {
            return
        }
        guard let buttonIndex = tabButtons.firstIndex(of: tabView) else {
            return
        }
        let viewToScrollTo = viewsToScrollTo[buttonIndex]
        scrollView.scrollRectToVisible(viewToScrollTo.frame, animated: true)
        setSelectedButton(index: buttonIndex)
    }
    
    private func setSelectedButton(index selectedIndex: Int) {
        for index in 0..<tabButtons.count {
            tabButtons[index].isSelected = (index == selectedIndex)
        }
    }
    
    func didNotifyOfScroll(contentOffset: CGPoint) {
        // I would favour doing this so that the screen that was _most_ in view got chosen
        // however, this is much faster, and will do for this technical test. There is code
        // that solves this problem on my GitHub already.
        let viewsInFrame  = viewsToScrollTo.filter {
            $0.frame.origin.x == contentOffset.x
        }
        if viewsInFrame.count != 1 {
            return
        }
        let currentlyDisplayedView = viewsInFrame.first!
        guard let viewIndex = viewsToScrollTo.firstIndex(of: currentlyDisplayedView) else {
            return
        }
        setSelectedButton(index: viewIndex)
        
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
        scrollView.tabbableDelegate = self
    }
}
