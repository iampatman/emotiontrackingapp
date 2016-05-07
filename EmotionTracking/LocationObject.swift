//
//  LocationObject.swift
//  EmotionTracking
//
//  Created by Vuong Quy Ngoc on 5/6/16.
//  Copyright © 2016 NguyenTrung. All rights reserved.
//

import Foundation
import MapKit

class LocationObject: NSObject, MKAnnotation  {
    var title: String? //emotion
    var subtitle: String? //thought
    var username: String
    var latitude: Double
    var longitude: Double
    var time: NSDate
    var mobileNumber: String
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init (title: String, subtitle: String, username: String, latitude: Double, longitude: Double, time: NSDate, mobileNumber: String){
        self.title = title
        self.subtitle = subtitle
        self.username = username
        self.latitude = latitude
        self.longitude = longitude
        self.time = time
        self.mobileNumber = mobileNumber
    }
    
    func pinTintColor() -> UIColor!  {
        switch title! as String {
        case "Happy":
            return UIColor.greenColor()
        case "Sad":
            return UIColor.blueColor()
        case "Afraid":
            return UIColor.brownColor()
        case "Angry":
            return UIColor.yellowColor()
        case "Despressed":
            return UIColor.darkGrayColor()
        default:
            return UIColor.redColor()
        }
    }
}