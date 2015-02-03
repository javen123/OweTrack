//
//  TracksOutVC.swift
//  OweTrack
//
//  Created by Jim Aven on 1/28/15.
//  Copyright (c) 2015 Neva. All rights reserved.
//

import UIKit

class TracksOutVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        let cell = tableView.dequeueReusableCellWithIdentifier("trackOutCell") as UITableViewCell
        
        var trackInfo:String!
        
        if tracksOutArray.count > 0 {
            trackInfo = "$\(tracksOutArray[indexPath.row].amount),  Due:  \(tracksOutArray[indexPath.row].date)"
            
        }
        
        cell.textLabel?.text = trackInfo
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let tableRows = tracksOutArray.count
        
        return tableRows
        
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "You owe"
        }
        else {
            return "Closed"
        }
    }
}

