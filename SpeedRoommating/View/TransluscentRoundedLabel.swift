//
//  TransluscentRoundedLabel.swift
//  SpeedRoommating
//
//  Created by Thomas Lee on 20/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class TransluscentRoundedLabel : UIView {
    
    let label = UILabel()
    
    @IBInspectable var labelText: String {
        set(value) {
            self.label.text = value.uppercased()
            self.setNeedsLayout()
            self.setNeedsUpdateConstraints()
        }
        get {
            return self.label.text ?? ""
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.backgroundColor = UIColor(named: "TransluscentBlack")
        self.layer.cornerRadius = 3
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFCompactDisplay-Medium", size: 16)
        label.textColor = UIColor.white
        self.addSubview(label)
        
        let leadingLabelConstraint = NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 8)
        let trailingLabelConstraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: label, attribute: .trailing, multiplier: 1, constant: 8)
        let topLabelConstraint = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 4)
        let bottomLabelConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: label, attribute: .bottom, multiplier: 1, constant: 4)
        
        NSLayoutConstraint.activate([leadingLabelConstraint, trailingLabelConstraint, topLabelConstraint, bottomLabelConstraint])
    }
}
