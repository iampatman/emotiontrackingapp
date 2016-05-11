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
    
    var activityHistory: [Activity] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        activityHistory = DataManagement.getInstance().selectAllActivities(username)
        tableView.reloadData()
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityHistory.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SecondOneCell
            let activity = activityHistory[activityHistory.count-indexPath.row-1]
            
            cell.thoughtLable.text = "\(activity.thought)"
            cell.timeLable.text = "\(activity.time)"
            //cell.textLabel?.text = "\(activity.thought)"
            //cell.detailTextLabel?.text = "\(activity.time)"
            if (activity.emotionId < 1 || activity.emotionId > 5){
                activity.emotionId = 1
            }
            let filename = Utils.emotionImagesFileName[activity.emotionId-1] + "_normal"
            cell.imageCell.image = UIImage(named: filename)
            //UIImage.FromBundle(named: filename))
            //UIImage.
            //cell.imageView!.image = UIImage(named: filename)
            return cell
        }
        
}

