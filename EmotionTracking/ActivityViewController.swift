//
//  ActivityViewController.swift
//  EmotionTracking
//
//  Created by student on 5/5/16.
//  Copyright © 2016 NguyenTrung. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {
    
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var emotionId: UITextField!
    @IBOutlet weak var thought: UITextField!
    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var longitude: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func createActivities(sender: AnyObject) {
        let usernameStr = "Chen Yao"
        let emotionIdInt = Int(emotionId.text!) as NSInteger?
        let long: Double = 103.776611
        let lat: Double = 1.292516
        let thoughtStr = thought.text! as String
        
        let newActivity: Activity = Activity.init(username: usernameStr, emotionId: emotionIdInt!, longitude: long, latitude: lat, thought: thoughtStr)
        DataManagement.getInstance().addNewActivity(newActivity)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}