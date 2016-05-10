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
        tableView.rowHeight = 50
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
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let activity = activityHistory[activityHistory.count-indexPath.row-1]
        cell.textLabel?.text = "\(activity.thought)"
        cell.detailTextLabel?.text = "\(activity.time)"
//        if (activity.emotionId < 1 || activity.emotionId > 5){
//            activity.emotionId = 1
//        }
//        if let thougutLabel = cell.viewWithTag(100) as? UILabel{
//            thougutLabel.text = activity.thought
//        }
//        if let timeLabel = cell.viewWithTag(101) as? UILabel {
//            timeLabel.text = "\(activity.time)"
//        }
         let filename = Utils.emotionImagesFileName[activity.emotionId-1] + "_normal"
//        if let emotionImage = cell.viewWithTag(102) as? UIImageView {
//            emotionImage.image = UIImage(named: filename)
//        }
        cell.imageView!.image = UIImage(named: filename)
        return cell
    }
}

