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
    
    var xTrack = [(amount:"0", ower:"0", date:"0")]
    
    override func viewWillAppear(animated: Bool) {
        
        var tracksInTableInfo = DataController.trackTableDataArray(APIArray)
        
        xTrack = tracksInTableInfo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UItableViewDataSource
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("trackInCell") as UITableViewCell
        
        var trackInfo:String!
        
        if xTrack.capacity > 0 {
            trackInfo = "$\(xTrack[indexPath.row].amount),   \(xTrack[indexPath.row].ower),   Due:  \(xTrack[indexPath.row].date)"
            
        }
        
        cell.textLabel?.text = trackInfo
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
    return cell
    
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let tableRows = xTrack.capacity
        
        
    return tableRows
    }

    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }

}
