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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldMobileNumber: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBAction func sendMessage(sender: AnyObject) {

        let msgComposer = MessageComposer()
        msgComposer.sendMessage("Hello dude", number: "81733082", parentView: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let tabbarVC = segue.destinationViewController as! UITabBarController
        if (segue.identifier == "login"){
            if let nextVC:FirstViewController = (segue.destinationViewController as? UITabBarController)!.viewControllers![0] as? FirstViewController {
                nextVC.username = textFieldUsername.text!
            }
            
            let navigationUIVC: UINavigationController = ((segue.destinationViewController as? UITabBarController)!.viewControllers![1] as? UINavigationController)!
            
            if let nextVC:SecondViewController = navigationUIVC.childViewControllers[0] as? SecondViewController {
                nextVC.username = textFieldUsername.text!
            }
            
        }
    }
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if (identifier=="login"){            
            return loginResult == 1
        }
        return false
    }
    @IBAction func loginAction(sender: AnyObject) {
        print("login press")
        activityIndicator.startAnimating()
        let username = textFieldUsername.text
        let mobilePhone = textFieldMobileNumber.text
        let params: [String:String] = ["username":username!,"mobilePhone":mobilePhone!]
        Utils.sendHTTPPostRequest("https://emotionstrackingapp.herokuapp.com/addUser", params: params){(returnData: NSDictionary) in
            print("Result from Login Screen: \(returnData)")
            
            let returnCode: Int = (returnData["result"] as? Int)!
            print("Result from Login Screen: \(returnCode)")
            self.activityIndicator.stopAnimating()
            if (returnCode == 1 || returnCode == 2){
                self.performSegueWithIdentifier("login", sender: self)
            } else {
                Utils.showMessageBox("Your current username is duplicated", viewController: self)
            }            
        }
    }
    
    
}
