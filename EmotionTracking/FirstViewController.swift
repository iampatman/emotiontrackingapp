//
//  FirstViewController.swift
//  EmotionTracking
//
//  Created by student on 3/5/16.
//  Copyright © 2016 NguyenTrung. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    var activitiesList: [NSDictionary]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: #selector(self.updateMap),userInfo: self,repeats: true)
        
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateMap(){
        print("call json")
        let params = [:]
        Utils.sendHTTPPostRequest("https://emotionstrackingapp.herokuapp.com/listActivities", params: params){
            (returnJSON: NSDictionary) in
            //print(returnJSON["list"])
            self.activitiesList = returnJSON["list"] as? [NSDictionary]
            for activity in self.activitiesList! {
                //print(activity["location"]!)
                //Show pin on the map based on these values
                
            }
        }
      
    }

}

