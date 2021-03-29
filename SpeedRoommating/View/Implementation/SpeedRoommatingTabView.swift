//
//  SpeedRoommatingTabView.swift
//  SpeedRoommating
//
//  Created by Thomas Lee on 26/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class SpeedRoommatingTabView : UIView {
    
    var label = UILabel()
    let selectionIndicator = UILabel()
    let button = UIButton()
    
    @IBInspectable var isSelected: Bool = false {
        didSet {
            updateSelected()
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var labelText: String {
        set(value) {
            label.text = value.uppercased()
        }
        get {
            return label.text ?? ""
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
    
    private func updateSelected() {
        if isSelected {
            label.textColor = UIColor(named: "Active")
            selectionIndicator.backgroundColor = UIColor.init(named: "Active")
        } else {
            label.textColor = UIColor(named: "DustyGrey")
        }
        selectionIndicator.isHidden = !isSelected
    }
    
    private func setup() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name:"SFCompactDisplay-Medium", size: 13)
        
        addSubview(label)
        
        let labelCenterXConstraint = NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let labelCenterYConstraint = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 6)
        
        selectionIndicator.backgroundColor = UIColor.init(named: "Active")
        selectionIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(selectionIndicator)
        
        let selectionIndicatorBottomConstraint = NSLayoutConstraint(item: selectionIndicator, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let selectionIndicatorCenterXConstraint = NSLayoutConstraint(item: selectionIndicator, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let selectionIndicatorWidthConstraint = NSLayoutConstraint(item: selectionIndicator, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 24)
        let selectionIndicatorHeightConstraint = NSLayoutConstraint(item: selectionIndicator, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 2)

        NSLayoutConstraint.activate([labelCenterXConstraint,
                                     labelCenterYConstraint,
                                     selectionIndicatorBottomConstraint,
                                     selectionIndicatorCenterXConstraint,
                                     selectionIndicatorWidthConstraint,
                                     selectionIndicatorHeightConstraint
        ])
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        let buttonTopConstraint = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let buttonLeadingConstraint = NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let buttonTrailingConstraint = NSLayoutConstraint(item: button, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let buttonBottomConstraint = NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([buttonTopConstraint,
                                     buttonLeadingConstraint,
                                     buttonTrailingConstraint,
                                     buttonBottomConstraint])
        updateSelected()
    }
}
