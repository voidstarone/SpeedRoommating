
//
//  EventTableViewErrorCell.swift
//  SpeedRoommating
//
//  Created by Thomas Lee on 27/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation
import UIKit

class EventTableViewErrorCell : UITableViewCell, IEventTableViewErrorCell {
    var errorImageView: UIImageView = UIImageView()
    var errorTitleLabel: UILabel = UILabel()
    var errorDescriptionLabel: UILabel  = UILabel()
    var retryButton: FilledButton = FilledButton()
    var buttonCallback: (() -> Void)?
    
    private var shouldShowButton = false
    
    func setImage(_ image: UIImage, title: String, description: String) {
        errorImageView.image = image
        errorTitleLabel.text = title
        errorDescriptionLabel.text = description
        setupWithoutButton()
    }
    
    @objc private func buttonPressed() {
        buttonCallback?()
    }
    
    var rowHeight: CGFloat {
        get {
            // Really janky, should be worked out more intelligently
            return buttonCallback == nil ? 235 : 290
        }
    }
    
    func setButton(text: String, callback: @escaping () -> Void) {
        self.buttonCallback = callback
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        retryButton.setTitle(text, for: .normal)
        retryButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        addSubview(retryButton)
        
        let buttonTopConstraint = NSLayoutConstraint(item: retryButton, attribute: .top, relatedBy: .equal, toItem: errorDescriptionLabel, attribute: .bottom, multiplier: 1, constant: 12)
        let buttonCenterXConstraint = NSLayoutConstraint(item: retryButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([buttonTopConstraint,
                                     buttonCenterXConstraint])
    }
    
    func setupWithoutButton() {
        errorImageView.translatesAutoresizingMaskIntoConstraints = false
        errorTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        errorDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        errorTitleLabel.font = UIFont(name:"SFCompactDisplay-Medium", size: 8.5)
        errorTitleLabel.textColor = UIColor(named: "DustyGrey")
        errorDescriptionLabel.font = UIFont(name:"SFCompactDisplay-Regular", size: 8)
        errorDescriptionLabel.textColor = UIColor(named: "DustyGrey")
        errorDescriptionLabel.lineBreakMode = .byWordWrapping
        errorDescriptionLabel.numberOfLines = 0
        errorDescriptionLabel.textAlignment = .center
        
        
        
        addSubview(errorImageView)
        addSubview(errorTitleLabel)
        addSubview(errorDescriptionLabel)
  
        
        let errorImageViewTopConstraint = NSLayoutConstraint(item: errorImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 48)
        let errorImageViewCenterXConstraint = NSLayoutConstraint(item: errorImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let errorImageHeightConstraint = NSLayoutConstraint(item: errorImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 48)
        let errorImageWidthConstraint = NSLayoutConstraint(item: errorImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 48)
        
        NSLayoutConstraint.activate([errorImageViewTopConstraint,
                                     errorImageViewCenterXConstraint,
                                     errorImageHeightConstraint,
                                     errorImageWidthConstraint])
        
        let errorTitleViewTopConstraint = NSLayoutConstraint(item: errorTitleLabel, attribute: .top, relatedBy: .equal, toItem: errorImageView, attribute: .bottom, multiplier: 1, constant: 20)
        let errorTitleViewCenterXConstraint = NSLayoutConstraint(item: errorTitleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([errorTitleViewTopConstraint, errorTitleViewCenterXConstraint])
        
        let errorDescriptionViewTopConstraint = NSLayoutConstraint(item: errorDescriptionLabel, attribute: .top, relatedBy: .equal, toItem: errorTitleLabel, attribute: .bottom, multiplier: 1, constant: 12)
        let errorDescriptionViewLeadingConstraint = NSLayoutConstraint(item: errorDescriptionLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 24)
        let errorDescriptionViewTrailingConstraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: errorDescriptionLabel, attribute: .trailing, multiplier: 1, constant: 24)
        let errorDescriptionViewBottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: errorDescriptionLabel, attribute: .bottom, multiplier: 1, constant: 24)
        NSLayoutConstraint.activate([errorDescriptionViewTopConstraint,
                                     errorDescriptionViewLeadingConstraint,
                                     errorDescriptionViewTrailingConstraint,
                                     errorDescriptionViewBottomConstraint])
        
    }
}
