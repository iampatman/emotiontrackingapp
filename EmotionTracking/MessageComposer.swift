//
//  MessageComposer.swift
//  EmotionTracking
//
//  Created by Nguyen Bui An Trung on 6/5/16.
//  Copyright © 2016 NguyenTrung. All rights reserved.
//

import Foundation
import MessageUI

class MessageComposer: NSObject, MFMessageComposeViewControllerDelegate {
    
    
    func configuredMessageComposer() -> MFMessageComposeViewController {
        let messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.messageComposeDelegate = self  //  Make sure to set this property to self, so that the controller can be dismissed!
        return messageComposeVC
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        controller.dismissViewControllerAnimated(true, completion: nil)

        print("Send message result: \(result.rawValue)")

    }
}