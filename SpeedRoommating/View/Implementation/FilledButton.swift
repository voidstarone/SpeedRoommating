//
//  FilledButton.swift
//  SpeedRoommating
//
//  Created by Thomas Lee on 30/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation
import UIKit

class FilledButton : UIButton {
    override init(frame: CGRect) {
        super.init(frame:frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    func setup() {
        translatesAutoresizingMaskIntoConstraints  = false
        backgroundColor = UIColor(named: "Active")
        layer.cornerRadius = 8
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        guard let label = titleLabel else {
             return
        }
        
        let topConstraint = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 10)
        let leadingConstraint = NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 20)
        let trailingConstraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: label, attribute: .trailing, multiplier: 1, constant: 20)
        let bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: label, attribute: .bottom, multiplier: 1, constant: 10)
        
        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint])
    }
}
