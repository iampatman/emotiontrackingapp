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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}