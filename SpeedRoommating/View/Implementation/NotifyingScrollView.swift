//
//  TabbableScrollView.swift
//  SpeedRoommating
//
//  Created by Thomas Lee on 30/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation
import UIKit

protocol NotifyingScrollViewDelegate {
    func didNotifyOfScroll(contentOffset: CGPoint)
}

class NotifyingScrollView : UIScrollView, UIScrollViewDelegate {
    
    var tabbableDelegate: NotifyingScrollViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tabbableDelegate?.didNotifyOfScroll(contentOffset: scrollView.contentOffset)
    }
    
    func setup() {
        delegate = self
    }
}
