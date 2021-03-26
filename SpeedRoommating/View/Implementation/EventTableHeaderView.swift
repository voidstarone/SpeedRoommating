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
        isOpaque = true
        backgroundColor = UIColor.systemBackground
        headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = UIFont(name:"SFCompactDisplay-Medium", size: 16)
        headerLabel.textColor = UIColor(named: "DustyGrey")
        addSubview(headerLabel)
        
        let labelLeadingConstraint = NSLayoutConstraint(item: headerLabel!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 12)
        let labelTrailingConstraint = NSLayoutConstraint(item: headerLabel!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 12)
        let labelBottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: headerLabel!, attribute: .bottom, multiplier: 1, constant: 6)
        NSLayoutConstraint.activate([labelLeadingConstraint, labelTrailingConstraint, labelBottomConstraint])
    }
}
