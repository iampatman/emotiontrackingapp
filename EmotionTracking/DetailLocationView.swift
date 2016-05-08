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

class DetailLocationView: UIViewController, UITextFieldDelegate, UITextViewDelegate{
    var location : LocationObject!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var emotion: UILabel!
    @IBOutlet weak var thoughtDescription: UILabel!
    //var edidtingCourse : Course!
    
    @IBOutlet weak var textFieldMobile: UITextField!
    @IBOutlet weak var textFieldThought: UITextField!
    @IBOutlet weak var textFieldEmotion: UITextField!
    @IBOutlet weak var message: UITextView!
   
    @IBOutlet weak var sendButton: UIButton!
    //@IBOutlet weak var detailDescriptionLabel: UILabel!
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textFieldMobile.resignFirstResponder()
        textFieldThought.resignFirstResponder()
        textFieldEmotion.resignFirstResponder()
        message.resignFirstResponder()
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        message.becomeFirstResponder()
        // Do any additional setup after loading the view, typically from a nib.
        //self.configureView()
        // Build a programmatic view
        message.layer.cornerRadius = 5
        message.layer.borderWidth = 1
        message.layer.borderColor = UIColor(red:0.0/255.0, green:122.0/255.0, blue:255.0/255.0,alpha:1).CGColor as CGColorRef
        
        sendButton.layer.cornerRadius = 5
       
        textFieldMobile.delegate = self
        textFieldThought.delegate = self
        textFieldEmotion.delegate = self
        message.delegate = self
        
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
