//
//  MessageComposer.swift
//  EmotionTracking
//
//  Created by Nguyen Bui An Trung on 6/5/16.
//  Copyright © 2016 NguyenTrung. All rights reserved.
//

import Foundation
import MessageUI
class MessageComposer: UIViewController, MFMessageComposeViewControllerDelegate {
    
    func sendMessage(content: String, number: String, parentView: UIViewController){
        let messageVC: MFMessageComposeViewController = MFMessageComposeViewController()
        messageVC.body = content;
        messageVC.recipients = [number]
        
        messageVC.messageComposeDelegate = self;
        if (MFMessageComposeViewController.canSendText()){
            parentView.presentViewController(messageVC, animated: false, completion: nil)

        }
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        print("Send message result: \(result.rawValue)")
    }
}