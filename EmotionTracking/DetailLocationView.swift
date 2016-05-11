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
import MessageUI

class DetailLocationView: UIViewController, UITextFieldDelegate, UITextViewDelegate,MFMessageComposeViewControllerDelegate  {
    var location : LocationObject!

    //var edidtingCourse : Course!
    
    @IBOutlet weak var textFieldMobile: UITextField!
    @IBOutlet weak var textFieldThought: UITextField!
    @IBOutlet weak var labelEmotion: UILabel!
    @IBOutlet weak var imageEmotion: UIImageView!
    @IBOutlet weak var message: UITextView!
   
    @IBOutlet weak var sendButton: UIButton!

    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.configureView()
        // Build a programmatic view
        
      //  message.becomeFirstResponder()
        // Do any additional setup after loading the view, typically from a nib.
        //self.configureView()
        // Build a programmatic view
        message.layer.cornerRadius = 5
        message.layer.borderWidth = 1
        message.layer.borderColor = UIColor(red:0.0/255.0, green:122.0/255.0, blue:255.0/255.0,alpha:1).CGColor as CGColorRef
        
        sendButton.layer.cornerRadius = 5
        
        textFieldMobile.delegate = self
        textFieldThought.delegate = self
        message.delegate = self
       
    }
    
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        print("Send message result: \(result.rawValue)")
        if (result.rawValue != 0){
            self.performSegueWithIdentifier("backToMap", sender: self)
        }
        
    }

    @IBAction func sendMessage(){
        let messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.messageComposeDelegate = self
        messageComposeVC.body = message.text!
        messageComposeVC.recipients = [location.mobileNumber]
        self.presentViewController(messageComposeVC, animated: true, completion: nil)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = location.username
      //  userName.text = location.username
        labelEmotion.text = location.title
        textFieldThought.text = location.subtitle
        textFieldMobile.text = location.mobileNumber
        let filename = location.title!.lowercaseString + "_normal"
        imageEmotion.image = UIImage(named: filename)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
