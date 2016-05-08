//
//  Activity.swift
//  EmotionTracking
//
//  Created by student on 3/5/16.
//  Copyright © 2016 NguyenTrung. All rights reserved.
//

import Foundation

class Activity {
    var username: String!
    var thought: String!
    var emotionId: Int32
    var longitude: Double
    var latitude: Double
    var time:String
    
    init(username: String, emotionId: Int32, longitude: Double, latitude: Double, thought: String, time:String){
        self.username = username
        self.emotionId = emotionId
        self.longitude = longitude
        self.latitude = latitude
        self.thought = thought
        self.time = time //only for hishtory, if it's real please ignore this field
    }
}