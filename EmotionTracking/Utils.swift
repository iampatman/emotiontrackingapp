//
//  Utils.swift
//  EmotionTracking
//
//  Created by student on 3/5/16.
//  Copyright © 2016 NguyenTrung. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class Utils {
    
    static var emotionList = ["Happy", "Sad", "Despressed", "Afraid", "Anger"] //0...4
    static var emotionImagesFileName = ["excited","happy","apathetic","sad","angry"]

    class func currentDateTime() -> String{
        let todaysDate:NSDate = NSDate()
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
        let DateInFormat:String = dateFormatter.stringFromDate(todaysDate)
        return DateInFormat
    }
    
    class func dateFromString(date: String, format: String) -> NSDate {
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
        return dateFormatter.dateFromString(date)!
        
    }
    class func showMessageBox(content: String, viewController: UIViewController){
        let alertPopUp:UIAlertController = UIAlertController(title: "Alert", message: content, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "OK", style: .Cancel){
            action -> Void in
        }
        alertPopUp.addAction(cancelAction)
        viewController.presentViewController(alertPopUp, animated: true, completion: nil)
        
    }

    class func sendHTTPPostRequest(urlStr: String, params: NSDictionary, completion: (result: NSDictionary) -> Void) {
        print("Url request: \(urlStr)")
        print("Param request: \(params)")
        var resultJSON: NSDictionary = [:]
        let url: NSURL = NSURL(string: urlStr)!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        let defaultConfigObject: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session: NSURLSession = NSURLSession(configuration: defaultConfigObject, delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
        request.HTTPMethod = "POST"
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: .PrettyPrinted)
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            if (error != nil){
                print("Error: \(error?.localizedDescription)")
                completion(result: [:])
            }
            let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("Body: \(strData!)")
            
            do {
                resultJSON = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                completion(result: resultJSON)
            } catch let error as NSError {
                print(error.localizedDescription)
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
            }
            
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            
        }).resume()
    }
}