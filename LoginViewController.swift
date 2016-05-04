//
//  LoginViewController.swift
//  EmotionTracking
//
//  Created by student on 3/5/16.
//  Copyright © 2016 NguyenTrung. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var loginResult: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        DataManagement.initDatabase()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldMobileNumber: UITextField!
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if (identifier=="login"){
            return loginResult == 1
        }
        return false
    }
    @IBAction func loginAction(sender: AnyObject) {
        print("login press")
        let username = textFieldUsername.text
        let mobilePhone = textFieldMobileNumber.text
        let params: [String:String] = ["username":username!,"mobilePhone":mobilePhone!]
        Utils.sendHTTPPostRequest("https://emotionstrackingapp.herokuapp.com/addUser", params: params){(returnData: NSDictionary) in
            print("Result from Login Screen: \(returnData)")
            let returnCode: Int = (returnData["result"] as? Int)!
            print("Result from Login Screen: \(returnCode)")
            if (returnCode == 1){
                self.performSegueWithIdentifier("login", sender: self)
            } else {
                Utils.showMessageBox("Your current username is duplicated", viewController: self)

            }

            
        }
    }
    
    
}
