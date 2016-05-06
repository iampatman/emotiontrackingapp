//
//  MessageComposer.swift
//  EmotionTracking
//
//  Created by student on 5/5/16.
//  Copyright © 2016 NguyenTrung. All rights reserved.
//

import MessageUI

class MessageComposer: NSObject, MFMessageComposeViewControllerDelegate {
    
    
    func sendMessage(content: String, number: String, parentVC: UIViewController) {
        let messageVC = MFMessageComposeViewController()
        messageVC.body = content;
        messageVC.recipients = [number]
        messageVC.messageComposeDelegate = self;
        parentVC.presentViewController(messageVC, animated: false, completion: nil)
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        print("Send message code: \(result.rawValue)")
    }
}
