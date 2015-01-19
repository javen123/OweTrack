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
    
    let url = NSURL(string:"http://localhost:3000/api/v1/tracks")
    var request = NSMutableURLRequest(URL: url!)
    
    request.HTTPMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
    
        if data != nil {
           
           var json = JSON(data: data!)
           
           var newArray = json.arrayObject
          println(json)
            
           APIArray = newArray!
            
            // Add amounts to DashBoard arrays
            
            for (index:String, tracks:JSON) in json {
                
                if tracks["status"] == "Tracking" {
                        
                    if let m = tracks["owed"].string {
                            let x = m.toInt()
                            amountsInArray.append(x!)
                    }
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
    
    // Data func for adding to tracksIn table and tracksOut table
    
    class func trackTableDataArray (array:NSArray) -> [(amount:String, ower:String, date:String)] {
        
        var tracksInArray:[(amount:String, ower:String, date:String)] = []
        var iterateResult:(amount:String, ower:String, date:String)
        
        if array.count > 0 {
            for item in array {
                let amount:String = item["owed"] as String
                let ower:String = item["ower"] as String
                let date:String = item["startdate"] as String
                iterateResult = (amount:amount, ower:ower, date:date)
                tracksInArray += [iterateResult]
            }
        }
        
        println(tracksInArray)
        return tracksInArray
    }

}
