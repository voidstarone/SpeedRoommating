//
//  IEventTableViewCell.swift
//  SpeedRoommating
//
//  Created by Thomas Lee on 26/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation
import UIKit

class EventTableHeaderView : UIView, IEventTableHeaderView {
    var headerLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = UIFont(name:"SFCompactDisplay-Medium", size: 16)
        headerLabel.textColor = UIColor(named: "DustyGrey")
        addSubview(headerLabel)
        
        let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 40)
        
        let labelLeadingConstraint = NSLayoutConstraint(item: headerLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 12)
        let labelTrailingConstraint = NSLayoutConstraint(item: headerLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 12)
        let labelBottomConstraint = NSLayoutConstraint(item: headerLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 2)
    
        NSLayoutConstraint.activate([heightConstraint, labelLeadingConstraint, labelTrailingConstraint, labelBottomConstraint])
    }
}
