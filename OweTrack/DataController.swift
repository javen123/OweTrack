//
//  DataController.swift
//  OweTrack
//
//  Created by user on 12/26/14.
//  Copyright (c) 2014 Neva. All rights reserved.
//

import Foundation
import UIKit


class DataController {
    
    
   class func makeTrackAPIRequest ()  {
    
    var tracksInResult:(amount:String, date:String)
    var tracksOutResult:(amount:String,date:String)
    
        let prefs = NSUserDefaults.standardUserDefaults()
        
        if (prefs.valueForKey("APPTOKEN")) != nil {
            
            let token:String = prefs.valueForKeyPath("APPTOKEN") as String
            let url = NSURL(string:"http://localhost:3000/api/v1/tracks")
            let id:AnyObject = prefs.valueForKey("UID")!
            let newId:Int = Int(id as NSNumber)
            
            var request = NSMutableURLRequest(URL: url!)
            
            var err:NSError?
            
            request.HTTPMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue(token, forHTTPHeaderField: "X-AUTH-TOKEN")
            request.addValue("\(id)", forHTTPHeaderField: "X-USER")
            
            var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
            
            if data != nil {
                
                var json = JSON(data: data!)
                
                // Add amounts to DashBoard arrays and tracks arrays
                
                for (value, tracks) in json {
                    
                    let amount = tracks["owed"].intValue
                    let date = tracks["startdate"].stringValue
                    let m = tracks["owed"].intValue
                    let owee = tracks["owee"].intValue
                    let ower = tracks["ower"].intValue
                    
                    if tracks["status"] == "Tracking" {
                        if owee == newId {
                            tracksInResult.amount = "\(amount)"
                            tracksInResult.date = date
                            tracksInArray += [tracksInResult]
                            amountsInArray.append(amount)
                            println("amounts in :\(amountsInArray)")
                        }
                        if ower == newId {
                            tracksOutResult.amount = "\(amount)"
                            tracksOutResult.date = date
                            tracksOutArray += [tracksInResult]
                            println("amounts out:\(amountsOutArray)")
                        }
                        
                        println("tracks in array: \(tracksInArray)")
                       
                    }
                    if tracks["status"] == "Tracking" && tracks {
                        
                        if let m = tracks["owed"].string {
                            let x = m.toInt()
                            amountsOutArray.append(x!)
                        }
                    }
                }
            }
        }
    }
    
    
    // Delete session
    
    class func deleteSession () -> String {
        
            var error:NSError?
            let prefs = NSUserDefaults.standardUserDefaults()
            let token: String = (prefs.valueForKey("APPTOKEN")) as String
            
            var url:NSURL = NSURL(string: "http://localhost:3000/api/v1/sessions")!
        
            var post = ["user":["authentication_token":"\(token)"]]
            var postData = NSJSONSerialization.dataWithJSONObject(post, options: nil, error: &error)
            var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
            request.HTTPMethod = "DELETE"
            request.HTTPBody = postData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
        
            var reponseError: NSError?
            var response: NSURLResponse?
            
            var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&reponseError)
        
            let json = JSON(data:urlData!)
            let status = json["status"].stringValue
        
            if status == "200" {
                    prefs.removeObjectForKey("APPTOKEN")
                    prefs.removeObjectForKey("ISLOGGEDIN")
                    
            }
        return status
    }
    
       
}
