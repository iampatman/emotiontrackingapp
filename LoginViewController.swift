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
    
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginButton.layer.cornerRadius = 5
        textFieldUsername.becomeFirstResponder()
        
        textFieldUsername.delegate = self
        textFieldMobileNumber.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textFieldUsername.resignFirstResponder()
        textFieldMobileNumber.resignFirstResponder()
        return true
    }
    
    
    @IBAction func aboutUsButton(sender: AnyObject) {
        printMessage("\nNguyen Bui AN Trung\n Vuong Quy Ngoc\n Gao HaiJun\n Chen Yao\n Tang Ting")
        
    }
    func printMessage(name:String){
        let aletrPopUp:UIAlertController = UIAlertController(title:"About us.",message: name, preferredStyle:UIAlertControllerStyle.Alert)
        let cancelAction = UIAlertAction(title: "OK", style: .Cancel){action -> Void in}
        aletrPopUp.addAction(cancelAction)
        self.presentViewController(aletrPopUp, animated: true, completion: nil)
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
        if (segue.identifier == "login"){
            if let nextVC:FirstViewController = (segue.destinationViewController as? UITabBarController)!.viewControllers![0] as? FirstViewController {
                nextVC.username = textFieldUsername.text!
            }
            if let nextVC:SecondViewController = (segue.destinationViewController as? UITabBarController)!.viewControllers![1] as? SecondViewController {
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
