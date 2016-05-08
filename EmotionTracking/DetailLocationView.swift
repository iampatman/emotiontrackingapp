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
    
    @IBOutlet weak var textFieldMobile: UITextField!
    @IBOutlet weak var textFieldThought: UITextField!
    @IBOutlet weak var textFieldEmotion: UITextField!
    @IBOutlet weak var message: UITextView!
   
    //@IBOutlet weak var detailDescriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.configureView()
        // Build a programmatic view
            
       
    }
    @IBAction func sendMessage(){
        MessageComposer().sendMessage(message.text!, number: location.mobileNumber, parentView: self)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = location.username
        userName.text = location.username
        textFieldEmotion.text = location.title
        textFieldThought.text = location.subtitle
        textFieldMobile.text = location.mobileNumber
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
