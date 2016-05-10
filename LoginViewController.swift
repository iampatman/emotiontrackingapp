//
//  LoginViewController.swift
//  EmotionTracking
//
//  Created by student on 3/5/16.
//  Copyright © 2016 NguyenTrung. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var loginResult: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textFieldUsername.delegate = self
        textFieldMobileNumber.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldMobileNumber: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBAction func aboutUsButton(sender: AnyObject) {
        Utils.showMessageBox("\nNguyen Bui AN Trung\n Vuong Quy Ngoc\n Gao HaiJun\n Chen Yao\n Tang Ting",viewController: self)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textFieldUsername.resignFirstResponder()
        textFieldMobileNumber.resignFirstResponder()
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
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
        if (textFieldUsername.text == "" || textFieldMobileNumber.text == ""){
            Utils.showMessageBox("Username and Mobile number can not be empty", viewController: self)
        }
        loginButton.enabled = false
        textFieldUsername.resignFirstResponder()
        textFieldMobileNumber.resignFirstResponder()
        activityIndicator.startAnimating()
        let username = textFieldUsername.text
        let mobilePhone = textFieldMobileNumber.text
        let params: [String:String] = ["username":username!,"mobilePhone":mobilePhone!]
        Utils.sendHTTPPostRequest("https://emotionstrackingapp.herokuapp.com/addUser", params: params){(returnData: NSDictionary) in
            print("Result from Login Screen: \(returnData)")
            
            let returnCode: Int = (returnData["result"] as? Int)!
            print("Result from Login Screen: \(returnCode)")
            self.activityIndicator.stopAnimating()
            self.loginButton.enabled = true

            if (returnCode == 1 || returnCode == 2){
                self.performSegueWithIdentifier("login", sender: self)
            } else {
                Utils.showMessageBox("Your current username is duplicated", viewController: self)
            }            
        }
    }
    
    
}
