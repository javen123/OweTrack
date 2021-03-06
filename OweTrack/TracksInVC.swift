//
//  TracksInVC.swift
//  OweTrack
//
//  Created by user on 12/30/14.
//  Copyright (c) 2014 Neva. All rights reserved.
//

import UIKit

class TracksInVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
   @IBOutlet weak var tableView: UITableView!
    
   override func viewDidLoad() {
        super.viewDidLoad()
    
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    // MARK: - UItableViewDataSource
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("trackInCell") as UITableViewCell
        
        var trackInfo:String!
        
        if tracksInArray.count > 0 {
            trackInfo = "$\(tracksInArray[indexPath.row].amount),    Due:  \(tracksInArray[indexPath.row].date)"
            
        }
        
        cell.textLabel?.text = trackInfo
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
    return cell
    
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let tableRows = tracksInArray.count
        
     return tableRows
        
    }

    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Owed to you"
        }
        else {
            return "Closed"
        }
    }
    
}
