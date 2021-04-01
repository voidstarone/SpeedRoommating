//
//  EventTableCell.swift
//  SpeedRoommating
//
//  Created by Thomas Lee on 20/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation
import UIKit

class EventTableViewCell : UITableViewCell, IEventTableViewCell {
    
    @IBOutlet weak var backgroundImageView: UIImageView! {
        didSet {
            backgroundImageView.layer.cornerRadius = 3
        }
    }
    var backgroundImage: UIImage? {
        set(value) {
            backgroundImageView?.image = value
            placeholderContainer.isHidden = value != nil
        }
        get {
            return backgroundImageView?.image
        }
    }
    
    @IBOutlet weak var costLabel: TransluscentRoundedLabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    
    @IBOutlet weak var placeholderContainer: UIView! {
        didSet {
            placeholderContainer.layer.cornerRadius = 3
            placeholderContainer.layer.borderWidth = 0.5
            placeholderContainer.layer.borderColor = UIColor(named: "Detail")?.cgColor
        }
    }
    
    @IBOutlet weak var placeholderDetailRow1: UIView!
    @IBOutlet weak var placeholderDetailRow2: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func isAnyTextLabelEmpty() -> Bool {
        return dateLabel.text ?? "" == "" ||
        timeLabel.text ?? "" == "" ||
        locationLabel.text ?? "" == "" ||
        venueLabel.text ?? "" == "" ||
        costLabel.labelText == ""
    }
    
    func updatePlaceholder() {
        let isPopulated = !isAnyTextLabelEmpty()
        placeholderDetailRow1.isHidden = isPopulated
        placeholderDetailRow2.isHidden = isPopulated
        costLabel.isHidden = !isPopulated
    }
}
