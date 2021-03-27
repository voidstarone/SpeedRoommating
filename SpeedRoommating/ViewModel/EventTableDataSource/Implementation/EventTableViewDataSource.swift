//
//  EventTableDataSource.swift
//  SpeedRoommating
//
//  Created by Thomas Lee on 24/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import Foundation
import UIKit
import Network

public class EventTableViewDataSource : NSObject, IEventTableViewDataSource {

    var imageProvider: IImageProvider = KingfisherImageProvider(overrideScaleFactor: 1.0)
    var eventProvider: ISpeedRoommatingEventProvider = SpeedRoommatingEventProvider()
    var controlledTableView: UITableView!
    var firstCell: IEventTableViewErrorCell?
    let monitor = NWPathMonitor()
    
    private var eventSplitByMonth: [[IViewableEvent]]?
    private var sectionMonthNumbers: [Int]?

    override init() {
        imageProvider.deleteCache {}
    }
    
    func fetchEventsFromEventProvider(onComplete: @escaping (Error?) -> Void) {
        let fetchEventsThread = DispatchQueue(label: "fetchEvents", qos: .background)
        firstCell = nil
        fetchEventsThread.async {
            let monitor = NWPathMonitor()
            monitor.pathUpdateHandler = { path in
                if path.status != .satisfied {
                    self.firstCell = self.createNoNetworkCell()
                }
            }
            self.eventProvider.getEventsByYearAndMonth(onOrAfterDate: Date()) {
                result in
                var maybeError: Error? = nil
                switch(result) {
                case let .success(groupedEvents):
                    self.setGroupEvents(groupedEvents: groupedEvents)
                    break
                case let .failure(error):
                    self.handleFetchError(error)
                    maybeError = error
                }
                onComplete(maybeError)
            }
            DispatchQueue.main.async {
                self.controlledTableView.reloadData()
            }
        }
    }
    
    private func handleFetchError(_ error: Error) {
        guard let usableError = error as? RoommatingEventProviderError else {
             DispatchQueue.main.async {
                 self.firstCell = self.createUnknownErrorCell()
                 self.controlledTableView.reloadData()
             }
            return
         }
         switch usableError {
         case .network:
             DispatchQueue.main.async {
                 self.firstCell = self.createNoNetworkCell()
                 self.controlledTableView.reloadData()
             }
             break
         default:
             DispatchQueue.main.async {
                 self.firstCell = self.createUnknownErrorCell()
                 self.controlledTableView.reloadData()
             }
         }
    }

    private func setGroupEvents(groupedEvents: [Int : [Int : [ISpeedRoommatingEvent]]]) {
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
    }
    
    private func createNoNetworkCell() -> IEventTableViewErrorCell {
        let cell = EventTableViewErrorCell()
        cell.setImage(UIImage(named: "IconOffline")!,
                      title: "No connection",
                      description: "You appear to be offline. Check your mobile or wifi connection and try again.")
        cell.setButton(text: "Retry") {
            self.fetchEventsFromEventProvider {_ in }
        }
        return cell
    }
    
    private func createUnknownErrorCell() -> IEventTableViewErrorCell {
        let cell = EventTableViewErrorCell()
        cell.setImage(UIImage(named: "IconError")!,
                      title: "Something's gone wrong",
                      description: "We couldn't load the upcoming events. Check your cellular or wifi connection and try again.")
        cell.setButton(text: "Retry") {
            self.fetchEventsFromEventProvider {_ in }
        }
        return cell
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        let allMonthsCount = self.eventSplitByMonth?.count
        return allMonthsCount ?? 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let thisSectionsEventsCount = self.eventSplitByMonth?[section].count
        return thisSectionsEventsCount ?? 10
    }
    
    private func createFilledCell(for tableView: UITableView, eventForCell: ViewableEvent, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as! EventTableViewCell
        let durationText = eventForCell.durationText
        let shortReadableDate = eventForCell.dateAsShortReadable
        
        let heightConstraint = NSLayoutConstraint(item: cell, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 210)
        heightConstraint.isActive = true

        let imageTargetSize = cell.frame.size

        DispatchQueue.main.async {
            cell.locationLabel.text = eventForCell.location
            cell.venueLabel.text = eventForCell.venue
            cell.costLabel.labelText = eventForCell.cost
            cell.dateLabel.text = shortReadableDate
            cell.timeLabel.text = durationText
        }
        
        let fetchImageThread = DispatchQueue(label: "fetchImages", qos: .background)
        fetchImageThread.async {
            [weak self] in
            if (self == nil) {
                return
            }
            self?.imageProvider.requestImage(atUrl: eventForCell.imageUrlAt(size: imageTargetSize)) {
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

    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 && indexPath.row == 0 {
            if let returnCell = firstCell {
                return returnCell
            }
        }
        
        guard let eventForCell = eventSplitByMonth?[indexPath.section][indexPath.row] as? ViewableEvent else {
            // placeholder
            return UITableViewCell()
        }
        
        let cell = createFilledCell(for: tableView, eventForCell: eventForCell, at:indexPath)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            if let returnCell = firstCell {
                return returnCell.rowHeight
            }
        }
        return 210
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if eventSplitByMonth == nil || eventSplitByMonth?.count == 0 {
            return 0
        }
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
