//
//  EventListTableViewController.swift
//  SpeedRoommating
//
//  Created by Thomas Lee on 20/03/2021.
//  Copyright © 2021 Thomas Lee. All rights reserved.
//

import UIKit

struct EventMonth {
    var month: Int
    var events: [ISpeedRoommatingEvent]
}

class EventListTableViewController: UITableViewController {
    
    let imageProvider: IImageProvider = KingfisherImageProvider(overrideScaleFactor: 1.0)
    var eventProvider: ISpeedRoommatingEventProvider = SpeedRoommatingEventProvider()
    var eventSplitByMonth:
[[ISpeedRoommatingEvent]]?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventTableViewCell")
        imageProvider.deleteCache {}
        let fetchEventsThread = DispatchQueue(label: "fetchEvents", qos: .background)
        fetchEventsThread.async {
            self.eventProvider.getEventsByYearAndMonth(onOrAfterDate: Date()) {
                result in
                switch(result) {
                case let .success(groupedEvents):
                    self.eventSplitByMonth = []
                    for year in groupedEvents {
                        year.value.forEach {
                            month in
                            self.eventSplitByMonth?.append(month.value)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    break
                case let .failure(error):
                    //error
                    break
                }
            }
        }
        
        
    }
    
    private func isErrorState() {
        return
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections\
        let thisYearsMonths = self.eventSplitByMonth?.count
        return thisYearsMonths ?? 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
                        
        var thisSectionsEventsCount = self.eventSplitByMonth?[section].count
        
        //TODO: delete this
        thisSectionsEventsCount = min(thisSectionsEventsCount ?? 10, 5)
        
        return thisSectionsEventsCount ?? 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

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
            
            let durationText = self!.datesToDurationText(startTime: eventForCell.startTime, endTime: eventForCell.endTime)
            
            DispatchQueue.main.async {
                cell.locationLabel.text = eventForCell.location
                cell.venueLabel.text = eventForCell.venue
                cell.costLabel.labelText = eventForCell.cost
                cell.timeLabel.text = durationText
            }
            
            self!.imageProvider.requestImage(named: eventForCell.imageName, atSize: imageTargetSize) {
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
    
    func datesToDurationText(startTime: Date, endTime: Date) -> String {
        let calendar = Calendar.current
        let startTimeComponents = calendar.dateComponents([.hour, .minute], from: startTime)
        let endTimeComponents = calendar.dateComponents([.hour, .minute], from: endTime)
     
        return "\(startTimeComponents.hour!):\(startTimeComponents.minute!) — \(endTimeComponents.hour!):\(endTimeComponents.minute!)"
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 210.0
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
