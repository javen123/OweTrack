//
//  DashBoardVC.swift
//  OweTrack
//
//  Created by user on 12/23/14.
//  Copyright (c) 2014 Neva. All rights reserved.
//

import UIKit
import Foundation



class DashBoardVC: UIViewController, UITabBarControllerDelegate {
    
    @IBOutlet weak var netAmountLabel: UILabel!
    @IBOutlet weak var amountOwedLabel: UILabel!
    @IBOutlet weak var amountOweLabel: UILabel!
    
    var jsonResponse:NSDictionary!
    
    @IBOutlet weak var tabBar: UITabBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        amountsLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        DataController.makeTrackAPIRequest()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
       
        DataController.makeTrackAPIRequest()
        amountsLabels()
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isLoggedIn:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        
        if prefs.valueForKey("ISLOGGEDIN") == nil {
            performSegueWithIdentifier("signInSegue", sender: self)
        }
    }

    @IBAction func logoutButtonPressed(sender: AnyObject) {
        
        if DataController.deleteSession() == "200" {
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Logged Out!"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            
            performSegueWithIdentifier("signInSegue", sender: self)
            
        }
        else {
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "There was an error loggin out!"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()

        }
        
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
