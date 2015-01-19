//
//  DashBoardVC.swift
//  OweTrack
//
//  Created by user on 12/23/14.
//  Copyright (c) 2014 Neva. All rights reserved.
//

import UIKit
import Foundation



class DashBoardVC: UIViewController {

    @IBOutlet weak var netAmountLabel: UILabel!
    @IBOutlet weak var amountOwedLabel: UILabel!
    @IBOutlet weak var amountOweLabel: UILabel!
    
    var jsonResponse:NSDictionary!
    
    override func viewWillAppear(animated: Bool) {
//        DataController.makeTrackAPIRequest()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        amountsLabels()
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isLoggedIn:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        if (isLoggedIn != 1) {
            self.performSegueWithIdentifier("signInSegue", sender: self)
        }
    }
    @IBAction func testButtonPressed(sender: AnyObject) {
        
        performSegueWithIdentifier("tracksInVCSegue", sender: self)
    }
    
    @IBAction func createNewTrackButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("createNewTrackSegue", sender: self)
    }
    
    // Update amount labels
    
    func amountsLabels () {
        
        let amountIn = amountsInArray.reduce(0,+)
        let amountOut = amountsOutArray.reduce(0,+)
        let netAmount = amountIn - amountOut
        
        if amountsInArray.count >= 1 {
            amountOwedLabel.textColor = UIColor.greenColor()
            amountOwedLabel.text = "$\(amountIn)"
            
        }
        else {
            amountOwedLabel.text = "$0"
        }
        
        if amountsOutArray.count >= 1 {
            amountOweLabel.textColor = UIColor.redColor()
            amountOweLabel.text = "$\(amountOut)"
        }
        else {
            amountOweLabel.text = "$0"
        }
        
        if netAmount < 0 {
            netAmountLabel.textColor = UIColor.redColor()
            netAmountLabel.text = "$-\(netAmount)"
        }
        else if netAmount == 0 {
            netAmountLabel.textColor = UIColor.blackColor()
        }
        else {
            netAmountLabel.textColor = UIColor.greenColor()
            netAmountLabel.text = "$\(netAmount)"
        }
        
        amountsInArray.removeAll(keepCapacity: false)
        amountsOutArray.removeAll(keepCapacity: false)
 
    }
        
}
