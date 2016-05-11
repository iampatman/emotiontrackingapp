//
//  ActivityTest.swift
//  EmotionTracking
//
//  Created by chenyao on 11/05/16.
//  Copyright © 2016年 NguyenTrung. All rights reserved.
//

import XCTest
import Darwin
@testable import EmotionTracking

class ActivityTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //chen yao
    func testPostActivity()  {
        //normal post
        let activity1:ActivityViewController? = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("postActivityView") as! ActivityViewController
        let _ = activity1!.view
        activity1!.username = "chenyao"
        activity1!.emotionIdInt = 1
        activity1?.thought.text = "I'm excited"
        activity1!.long = 103.7829
        activity1!.lat = 1.294455
        activity1?.createActivities(activity1!)
        
        //wait since server response need some time
        sleep(3)
        XCTAssertFalse(activity1!.postButton.enabled, "post button should be disabled")
        XCTAssert(activity1!.returnCode == 0, "return code should be equal 0")
        
        //same username but different emotion and thought
        let activity2:ActivityViewController?  = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("postActivityView") as! ActivityViewController
        let _ = activity2!.view
        activity2!.username = "chenyao"
        activity2!.emotionIdInt = 4
        activity2?.thought.text = "I'm sad now"
        activity2!.long = 103.7829
        activity2!.lat = 1.294455
        activity1?.createActivities(activity2!)
        //wait since server response need some time
        sleep(3)
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}