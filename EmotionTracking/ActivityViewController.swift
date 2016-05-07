//
//  ActivityViewController.swift
//  EmotionTracking
//
//  Created by student on 5/5/16.
//  Copyright © 2016 NguyenTrung. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var thought: UITextField!
    var emotionIdInt:Int = 0
    
    @IBAction func cuteTap(sender: AnyObject) {
        emotionIdInt = 1
    }
    
    @IBAction func happyTap(sender: AnyObject) {
        emotionIdInt = 2
    }
    
    @IBAction func smileTap(sender: AnyObject) {
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
        // Do any additional setup after loading the view, typically from a nib
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 15
        let currentgString:NSString = textField.text!
        let newString:NSString = currentgString.stringByReplacingCharactersInRange(range, withString: string)
        
        return newString.length <= maxLength   
    }
    
    @IBAction func createActivities(sender: AnyObject) {
        userNameLabel.text = "Chen Yao"
        let usernameStr = userNameLabel.text!
        let long: Double = 103.776611
        let lat: Double = 1.292516
        let thoughtStr = thought.text! as String
        thought.text = thoughtStr
        
        let newActivity: Activity = Activity.init(username: usernameStr, emotionId: emotionIdInt, longitude: long, latitude: lat, thought: thoughtStr)
        DataManagement.getInstance().addNewActivity(newActivity)
        
        let params = ["usernameStr":usernameStr, "emotionIdInt":emotionIdInt, "long":long, "lat":lat, "thoughtStr":thoughtStr]
        
      Utils.sendHTTPPostRequest("https://emotionstrackingapp.herokuapp.com/postActivity", params: params){(returnData: NSDictionary) in
                let returnCode: Int = (returnData["result"] as? Int)!
            if (returnCode == 1){
                self.performSegueWithIdentifier("gotoMapView", sender: self)
            } else {
                Utils.showMessageBox("Add activity failed", viewController: self)
            }
            print(returnCode)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}