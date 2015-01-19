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
        
        self.resignFirstResponder()

        // Do any additional setup after loading the view.
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
            println(datePicker.date)
            let token = NSUserDefaults.standardUserDefaults()
            let token1:String = token.valueForKey("APPTOKEN") as String
            var post = ["@track.owed":"\(owerAmount)","@track.startDate":"\(date)", "@track.status":"Tracking"]
           
            NSLog("PostData: %@",post);
            var error:NSError?
            var url:NSURL = NSURL(string: "http://localhost:3000/api/v1/tracks")!
            
            var postData = NSJSONSerialization.dataWithJSONObject(post, options: NSJSONWritingOptions(), error: &error)
            
            var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.HTTPBody = postData
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("authenticityToken", forKey: token1)
            
            var reponseError: NSError?
            var response: NSURLResponse?
            
            var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&reponseError)
            
            if ( urlData != nil ) {
                
                let res = response as NSHTTPURLResponse!;
                
                println("Response code: \(res.statusCode)")
                
                if (res.statusCode >= 200 && res.statusCode < 300) {
                    
                    var responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                    
                    println("Response ==> \(responseData)")
                    
                    var error: NSError?
                    
                    let jsonData:NSDictionary = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers , error: &error) as NSDictionary
                    
                    println("jasonData: \(jsonData)")
                }
           }
       }
    }
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Date formatter
    
    func APIDateFormatter (date:NSDate) ->String {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/dd/mm"
        let apiDate = dateFormatter.stringFromDate(date)
        
        return apiDate
    }
    
    
}
