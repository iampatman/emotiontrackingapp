//
//  SecondViewController.swift
//  EmotionTracking
//
//  Created by student on 3/5/16.
//  Copyright © 2016 NguyenTrung. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var username: String = ""
    
    let activityHistory = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityHistory.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        DataManagement.getInstance().selectAllActivities(username)

        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let activity = activityHistory[activityHistory.count-indexPath.row-1] as! Activity
        //
        //to do more work to parse the raw data for better presentation
        //1. convert emothion id into actual emotion(happy, unhappy)
        //2. convert numeric loaciont info into actual location name
        //
        cell.textLabel?.text = "\(activity.time): Emotion:\(activity.emotionId), Location(\(activity.longitude),\(activity.latitude))"
        
        return cell
    }

}

