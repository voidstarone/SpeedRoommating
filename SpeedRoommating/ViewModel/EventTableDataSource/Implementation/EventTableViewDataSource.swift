//
//  EventTableDataSource.swift
//  SpeedRoommating
//
//  Created by Thomas Lee on 24/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation
import UIKit

public class EventTableViewDataSource : NSObject, IEventTableViewDataSource {

    var imageProvider: IImageProvider = KingfisherImageProvider(overrideScaleFactor: 1.0)
    var eventProvider: ISpeedRoommatingEventProvider = SpeedRoommatingEventProvider()
    
    private var eventSplitByMonth: [[IViewableEvent]]?
    private var sectionMonthNumbers: [Int]?

    override init() {
        imageProvider.deleteCache {}
    }
    
    func fetchEventsFromEventProvider(onComplete: @escaping (Error?) -> Void) {
        let fetchEventsThread = DispatchQueue(label: "fetchEvents", qos: .background)
        fetchEventsThread.async {
            self.eventProvider.getEventsByYearAndMonth(onOrAfterDate: Date()) {
                result in
                switch(result) {
                case let .success(groupedEvents):
                    self.eventSplitByMonth = []
                    self.sectionMonthNumbers = []
                    let sortedYears = Array(groupedEvents.keys).sorted(by: <)
                    for yearNumber in sortedYears {
                        let year = groupedEvents[yearNumber]!
                        let sortedMonths = groupedEvents[yearNumber]!.keys.sorted(by: <)
                        self.sectionMonthNumbers!.append(contentsOf: sortedMonths)
                        for monthNumber in sortedMonths {
                            let month = year[monthNumber]!
                            self.eventSplitByMonth?.append(month.map { ViewableEvent(event: $0) })
                        }
                    }
                    DispatchQueue.main.async {
                        onComplete(nil)
                    }
                    break
                case let .failure(error):
                    onComplete(error)
                    //error
                    break
                }
            }
        }
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        let allMonthsCount = self.eventSplitByMonth?.count
        return allMonthsCount ?? 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let thisSectionsEventsCount = self.eventSplitByMonth?[section].count
        return thisSectionsEventsCount ?? 10
    }

    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as! EventTableViewCell
        let heightConstraint = NSLayoutConstraint(item: cell, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 210)
        heightConstraint.isActive = true
        let imageTargetSize = cell.frame.size
        
        guard let eventForCell = eventSplitByMonth?[indexPath.section][indexPath.row] else {
            // placeholder
            return cell
        }
        
        let fetchImageThread = DispatchQueue(label: "fetchImages", qos: .background)
        fetchImageThread.async {
            [weak self] in
            if (self == nil) {
                return
            }
            
            let durationText = eventForCell.durationText
            let shortReadableDate = eventForCell.dateAsShortReadable
            
            DispatchQueue.main.async {
                cell.locationLabel.text = eventForCell.location
                cell.venueLabel.text = eventForCell.venue
                cell.costLabel.labelText = eventForCell.cost
                cell.dateLabel.text = shortReadableDate
                cell.timeLabel.text = durationText
            }
            
            self!.imageProvider.requestImage(atUrl: eventForCell.imageUrlAt(size: imageTargetSize)) {
                result in
                switch result {
                case let .failure(error):
                    print(error)
                    // TODO: no big deal; just get a placeholder
                    break
                case let .success(image):
                    DispatchQueue.main.async {
                        cell.backgroundImageView.image = image
                    }
                }
            }
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = EventTableHeaderView()
        guard let monthNumber = sectionMonthNumbers?[section] else {
            return UIView()
        }
        let monthName = DateFormatter().monthSymbols?[monthNumber - 1]
        headerView.headerLabel.text = monthName
        
        return headerView
    }
}
