//
//  ActivityViewController.swift
//  EmotionTracking
//
//  Created by student on 5/5/16.
//  Copyright © 2016 NguyenTrung. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController,UITextFieldDelegate {
    
    
    var returnCode: Int = 0
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var thought: UITextField!
    var emotionIdInt:Int = 0
    
    @IBAction func excitedTap(sender: AnyObject) {
        emotionIdInt = 1
    }
    
    @IBAction func happyTap(sender: AnyObject) {
        emotionIdInt = 2
    }
    
    @IBAction func apatheticTap(sender: AnyObject) {
        emotionIdInt = 3
    }
    
    @IBAction func sadTap(sender: AnyObject) {
        emotionIdInt = 4
    }
    
    @IBAction func angryTap(sender: AnyObject) {
        emotionIdInt = 5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       thought.delegate = self
    userNameLabel.text = "trung"

        // Do any additional setup after loading the view, typically from a nib
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if (identifier == "gotoMapView"){
            return returnCode == 1
        }
        return false;
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 15
        let currentgString:NSString = textField.text!
        let newString:NSString = currentgString.stringByReplacingCharactersInRange(range, withString: string)
        return newString.length <= maxLength   
    }
    
    @IBAction func createActivities(sender: AnyObject) {
        let usernameStr = userNameLabel.text!
        let long: Double = 103.776611
        let lat: Double = 1.292516
        let thoughtStr = thought.text! as String
        thought.text = thoughtStr
        
        let newActivity: Activity = Activity.init(username: usernameStr, emotionId: emotionIdInt, longitude: long, latitude: lat, thought: thoughtStr)
        DataManagement.getInstance().addNewActivity(newActivity)
        
        let params = ["username":usernameStr, "emotionId":emotionIdInt, "longitude":long, "latitude":lat, "thought":thoughtStr]
        
      Utils.sendHTTPPostRequest("https://emotionstrackingapp.herokuapp.com/postActivity", params: params){(returnData: NSDictionary) in
                let resultCode: Int = (returnData["result"] as? Int)!
            self.returnCode = resultCode
        print(resultCode)

            if (resultCode == 1){
                self.performSegueWithIdentifier("gotoMapView", sender: self)
            } else {
                Utils.showMessageBox("Add activity failed", viewController: self)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}