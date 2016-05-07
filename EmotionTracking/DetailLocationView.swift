//
//  DetailLocationView.swift
//  EmotionTracking
//
//  Created by Vuong Quy Ngoc on 5/7/16.
//  Copyright © 2016 NguyenTrung. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class DetailLocationView: UIViewController {
    var location : LocationObject!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var emotion: UILabel!
    @IBOutlet weak var thoughtDescription: UILabel!
    //var edidtingCourse : Course!
    
    @IBOutlet weak var message: UITextView!
   
    //@IBOutlet weak var detailDescriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.configureView()
        // Build a programmatic view
        view.backgroundColor = UIColor(
            red: 0.8,
            green: 0.5,
            blue: 0.2,
            alpha: 1.0)
    
       
    }
    @IBAction func sendMessage(){
        MessageComposer().sendMessage(message.text!, number: location.mobileNumber, parentView: self)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        userName.text = location.username
        emotion.text = location.title
        thoughtDescription.text = location.subtitle
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
