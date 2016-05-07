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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldUsername.delegate = self
        textFieldMobileNumber.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 10
    }

    
    @IBAction func sendsms(sender: AnyObject) {
        MessageComposer().sendMessage("hello", number: "12143", parentView: self)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldMobileNumber: UITextField!
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
        let username = textFieldUsername.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).lowercaseString
        let mobilePhone = textFieldMobileNumber.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
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
