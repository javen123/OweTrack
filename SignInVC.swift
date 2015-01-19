//
//  SignInVC.swift
//  OweTrack
//
//  Created by user on 12/22/14.
//  Copyright (c) 2014 Neva. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var jsonResponse:NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInButtonPressed(sender: UIButton) {
        
        var username = emailTextField.text
        var password = passwordTextField.text
        
        if ( username == nil || password == nil) {
        
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign in Failed!"
            alertView.message = "Please enter Username and Password"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
        else {
            
            var post = ["email":"\(username)","password":"\(password)"]
            
            NSLog("PostData: %@",post);
            var error:NSError?
            var url:NSURL = NSURL(string: "http://localhost:3000//api/v1/users/sign_in")!
            
            var postData = NSJSONSerialization.dataWithJSONObject(post, options: NSJSONWritingOptions(), error: &error)
            
            var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.HTTPBody = postData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
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
                    
                    let success:NSInteger = jsonData.valueForKey("success") as NSInteger
                    let token:NSString = jsonData.valueForKey("token") as NSString
                    
                    if success == 1 {
                        
                        println("Success: \(success)")
                        println("Login SUCCESS")
                            
                        var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                        prefs.setValue(success, forKey: "ISLOGGEDIN")
                        prefs.setValue(token, forKey: "APPTOKEN")
                        prefs.synchronize()
                        
                        self.dismissViewControllerAnimated(true, completion: nil)

                    }
                    else  if jsonData["error_message"] as? NSString != nil {
                        
                        var error_msg:NSString
                        
                        error_msg = jsonData["error_message"] as NSString
                        error_msg = "Unknown Error"
                        
                        var alertView:UIAlertView = UIAlertView()
                        alertView.title = "Sign in Failed!"
                        alertView.message = error_msg
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                    }
                    
                }
                else {
                    var alertView:UIAlertView = UIAlertView()
                    alertView.title = "Sign in Failed!"
                    alertView.message = "Connection Failed"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                }
            }
            else {
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Sign in Failed!"
                alertView.message = "Connection Failure"
                if let error = reponseError {
                    alertView.message = (error.localizedDescription)
                }
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
            }
        }
    }
    
    @IBAction func needAccountButtonPressed(sender: UIButton) {
        performSegueWithIdentifier("newUserSegue", sender: self)
    }
   
        
  }
