//
//  ActivityTest.swift
//  EmotionTracking
//
//  Created by chenyao on 11/05/16.
//  Copyright © 2016年 NguyenTrung. All rights reserved.
//

import XCTest
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
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let activity1:ActivityViewController? = storyboard.instantiateViewControllerWithIdentifier("postActivityView") as? ActivityViewController
        activity1!.username = "chenyao"
        activity1!.emotionIdInt = 1
        activity1!.thought.text = "I'm excited"
        activity1!.long = 103.7829
        activity1!.lat = 1.294455
        activity1!.postButton.accessibilityLabel = "postActivityItem1"
        XCUIApplication().buttons["postActivityItem1"]
        
        XCTAssertFalse(activity1!.postButton.enabled, "post button should be disabled")
        XCTAssert(activity1!.returnCode == 0, "return code should be equal 0")
        
        //wait since server response need some time
        //waitForExpectationsWithTimeout(3, handler: { error in})
       
        //same username but different emotion and thought
//        let activity2:ActivityViewController?  = ActivityViewController()
//        activity2!.username = "chenyao"
//        activity2!.emotionIdInt = 4
//        activity2!.thought.text = "I'm sad now"
//        activity2!.long = 103.7829
//        activity2!.lat = 1.294455
//        activity2!.postButton.accessibilityLabel = "postActivityItem2"
//        XCUIApplication().buttons["postActivityItem2"]
//        
//        XCTAssertTrue(activity2!.postButton.enabled, "post button should be enabled")
//        XCTAssert(activity2!.returnCode == 1, "return code should be equal 1")
//        
//        //wait since server response need some time
//        waitForExpectationsWithTimeout(3, handler: { error in})
    }

    func testBack()  {
        //normal post
        let activity1:ActivityViewController?  = ActivityViewController()
        activity1!.navigationItem.leftBarButtonItem!.enabled = false
        
        XCTAssertFalse(activity1!.navigationItem.leftBarButtonItem!.enabled, "back button should be disabled")
        XCTAssert(activity1!.returnCode == 0, "return code should be equal 0")
        
        activity1!.navigationItem.leftBarButtonItem!.enabled = true
        activity1!.navigationItem.leftBarButtonItem!.accessibilityLabel = "backButton"
        XCUIApplication().buttons["backButton"]
        XCTAssertTrue(activity1!.navigationItem.leftBarButtonItem!.enabled, "back button should be enabled")
        XCTAssert(activity1!.returnCode == 1, "return code should be equal 1")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
