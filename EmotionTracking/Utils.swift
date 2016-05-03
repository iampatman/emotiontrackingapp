//
//  Utils.swift
//  EmotionTracking
//
//  Created by student on 3/5/16.
//  Copyright © 2016 NguyenTrung. All rights reserved.
//

import Foundation


class Utils {
    
    class func initializeDB(){
        
    }
    
    class func sendHTTPPostRequest(urlStr: String, params: NSDictionary) -> [String:AnyObject] {
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
            print("Error: \(error?.localizedDescription)")
            let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("Body: \(strData!)")
            
            do {
                resultJSON = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                
            } catch let error as NSError {
                print(error.localizedDescription)
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
            }
            
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            
        }).resume()
        return resultJSON as! [String : AnyObject]
    }
}