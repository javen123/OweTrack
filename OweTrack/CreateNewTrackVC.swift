//
//  CreateNewTrackVC.swift
//  OweTrack
//
//  Created by user on 12/30/14.
//  Copyright (c) 2014 Neva. All rights reserved.
//

import UIKit

class CreateNewTrackVC: UIViewController {
    
    @IBOutlet weak var owerEmailField: UITextField!
    @IBOutlet weak var owerAmountField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Label tabs resignn responders
        
        if self.owerAmountField.isFirstResponder() {
            self.owerAmountField.resignFirstResponder()
        }
        if self.owerEmailField.isFirstResponder() {
            self.owerEmailField.resignFirstResponder()
        }
        if self.datePicker.isFirstResponder() {
            self.datePicker.resignFirstResponder()
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createTrackField(sender: AnyObject) {
        
        if owerAmountField.text != nil && owerEmailField.text != nil {
            var owerAmount = owerAmountField.text
            var owerEmail = owerEmailField.text
            var date = APIDateFormatter(datePicker.date)
            
            let prefs = NSUserDefaults.standardUserDefaults()
            let uid:AnyObject = prefs.objectForKey("UID")!
            
            let token:String = prefs.valueForKey("APPTOKEN") as String
            
            var post = ["owee":"\(uid)","owed":"\(owerAmount)","startdate":"\(date)", "status":"Tracking", "ower": "\(owerEmail)"]
           
            println("PostData: \(post)")
            
            var error:NSError?
            var url:NSURL = NSURL(string: "http://localhost:3000/api/v1/tracks")!
            
            var postData = NSJSONSerialization.dataWithJSONObject(post, options: NSJSONWritingOptions(), error: &error)
            
            var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.HTTPBody = postData
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue(token, forHTTPHeaderField: "X-AUTH-TOKEN")
            
            
            var reponseError: NSError?
            var response: NSURLResponse?
            
            var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&reponseError)
            
            var json = JSON(data:urlData!)
            
            println("my response is:\(json)")
            
            var repsonseUID = uid.intValue
            
            if json["owee"] != nil {
                
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Track Created!"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
            
            self.dismissViewControllerAnimated(true, completion: nil)
            }
            else {
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Error"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
            }
            
       }
        else {
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Please fill in all the fields"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
    }
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Date formatter
    
    func APIDateFormatter (date:NSDate) -> String {
        
        println(date)
        
        let calendar = NSCalendar.currentCalendar()
        
        let components = calendar.components(.MonthCalendarUnit | .DayCalendarUnit | .YearCalendarUnit, fromDate: date)
        
        let apiDate = "\(components.month)/\(components.day)/\(components.year)"
        
        return apiDate
    }
    
    
}
