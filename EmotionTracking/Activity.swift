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
    var emotionId: Int
    var longitude: Double
    var latitude: Double
    var time: String
    init(username: String, emotionId: Int, longitude: Double, latitude: Double, thought: String){
        self.username = username
        self.emotionId = emotionId
        self.longitude = longitude
        self.latitude = latitude
        self.thought = thought
        self.time = ""
        
    }
    convenience init(username: String, emotionId: Int, longitude: Double, latitude: Double, thought: String, time: String){
        self.init(username: username, emotionId: emotionId, longitude: longitude, latitude: latitude, thought: thought)
        self.time = time

    }
}