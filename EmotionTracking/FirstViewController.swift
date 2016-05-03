//
//  FirstViewController.swift
//  EmotionTracking
//
//  Created by student on 3/5/16.
//  Copyright © 2016 NguyenTrung. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        callJson()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func callJson(){
        print("call json")
        let params = ["longitude":"1234", "mobilePhone":"8173308212143"] as Dictionary<String, String>
        let result: NSDictionary = Utils.sendHTTPPostRequest("https://emotionstrackingapp.herokuapp.com/listUsers", params: params)
        print(result)
    }

}

