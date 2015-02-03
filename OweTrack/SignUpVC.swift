//
//  SignUpVC.swift
//  OweTrack
//
//  Created by user on 1/14/15.
//  Copyright (c) 2015 Neva. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var yourNameTextField: UITextField!
    @IBOutlet weak var chooseUsernameTextField: UITextField!
    @IBOutlet weak var choosePasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func joinTheClubButtonPressed(sender: UIButton) {
        
        var user = yourNameTextField.text
        var username = chooseUsernameTextField.text
        var password = choosePasswordTextField.text
        
        if self.yourNameTextField.isFirstResponder() {
            self.yourNameTextField.resignFirstResponder()
        }
        if self.choosePasswordTextField.isFirstResponder() {
            self.choosePasswordTextField.resignFirstResponder()
        }
        if self.choosePasswordTextField.isFirstResponder() {
            self.choosePasswordTextField.resignFirstResponder()
        }

        if  user == nil || username == nil || password == nil {
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign Up Failed!"
            alertView.message = "Please enter all fields"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            
        }
        else {
            var error:NSError?
            var post = ["user":["name":"\(user)", "email":"\(username)", "password":"\(password)"]]
            
            println(post)
            
            var url:NSURL = NSURL(string: "http://localhost:3000/api/v1/registrations")!
            
            var postData = NSJSONSerialization.dataWithJSONObject(post, options: nil, error: &error)
            
            var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.HTTPBody = postData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            var reponseError: NSError?
            var response: NSURLResponse?
            
            var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&reponseError)
            
            if ( urlData != nil ) {
                
                let json = JSON(data:urlData!)
                println(json)
                
                let statusCode = json["status"].intValue
                let token = json["data"]["auth_token"].stringValue
                let uid = json["data"]["id"].stringValue
                let success = json["success"].intValue
                
                if success == 1 {
                    
                    let siVC = SignInVC()
                    
                    var prefs = NSUserDefaults.standardUserDefaults()
                    prefs.setValue(success, forKey: "ISLOGGEDIN")
                    prefs.setValue(token, forKey: "APPTOKEN")
                    prefs.setValue(uid, forKey: "UID")
                    var responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                    
                    var error: NSError?
                    
                    println("Sign Up SUCCESS")
                    
                    var alertView:UIAlertView = UIAlertView()
                    alertView.title = "Registered!"
                    alertView.message = "Now start tracking"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
//                    self.dismissViewControllerAnimated(false, completion: nil)
//                    siVC.dismissViewControllerAnimated(true, completion: nil)
                    var printToken: AnyObject? = prefs.valueForKey("APPTOKEN")
                    println("saved Token is: \(printToken)")
                    
                    self.presentingViewController?.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
                    
                }
                
                else {
                    var error_msg = json["info"]["password"].stringValue
                    
                    var alertView:UIAlertView = UIAlertView()
                    alertView.title = "Sign Up Failed!"
                    alertView.message = error_msg
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                }
                    
                        
                
            }
                
            else {
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign in Failed!"
            alertView.message = "Connection Failure"
            }
        }
    }
    
    @IBAction func alreadyAMemberButtonPressed(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
