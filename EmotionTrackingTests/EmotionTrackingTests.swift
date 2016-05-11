//

import XCTest
@testable import EmotionTracking

class EmotionTrackingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // Jun: Clearup server database before testing
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //haijun
    func testURLConnection() {
        let URL = "https://emotionstrackingapp.herokuapp.com/"
        let expectation = expectationWithDescription("GET \(URL)")
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(NSURL(string: URL)!, completionHandler: {(data, response, error) in
            expectation.fulfill()
            
            XCTAssertNotNil(data, "data should not be nil")
            XCTAssertNil(error, "error should be nil")
            
            if let HTTPResponse = response as! NSHTTPURLResponse! {
                XCTAssertEqual(HTTPResponse.URL!.absoluteString, URL, "HTTP response URL should be equal to original URL")
                XCTAssertEqual(HTTPResponse.statusCode, 200, "HTTP response status code should be 200")
                XCTAssertEqual(HTTPResponse.MIMEType! as String, "text/html", "HTTP response content type should be text/html")
            } else {
                XCTFail("Response was not NSHTTPURLResponse")
            }
        })
        task.resume()
        
        waitForExpectationsWithTimeout(task.originalRequest!.timeoutInterval, handler: { error in
            task.cancel() 
        }) 
    }
    
    func testLogin() {
        //normal login
        //let user1:LoginViewController? = LoginViewController()
        let user1:LoginViewController? = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! LoginViewController
        let URL = "http://emotionstrackingapp.herokuapp.com/login"
        let expectation = expectationWithDescription("POST \(URL)")
        let _ = user1!.view
        user1!.textFieldUsername.text = "test_1"
        user1!.textFieldMobileNumber.text = "00001"
        user1!.loginButton.sendActionsForControlEvents(.TouchUpInside)
        expectation.fulfill()
        
        XCTAssertFalse(user1!.loginButton.enabled, "login button should be disabled or please cleanup obsolate data")
        XCTAssert(user1!.loginResult==0, "login result should be greater than 0")
        
        //wait since server response need some time
        waitForExpectationsWithTimeout(3, handler: { error in XCTAssert(true, "set it as true")})
        
        //abnormal-1: same username but different phone number
        let user2:LoginViewController? = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! LoginViewController
        let _ = user2!.view
        user2!.textFieldUsername.text = "test_1"
        user2!.textFieldMobileNumber.text = "00002"
        user2!.loginButton.sendActionsForControlEvents(.TouchUpInside)
        
        XCTAssertFalse(user2!.loginButton.enabled, "login button should be enabled")
        XCTAssert(user2!.loginResult==0, "login result should be equal 0")
        
        //wait since server response need some time
        //waitForExpectationsWithTimeout(3, handler: { error in})
        
        //abnormal-2: same phone number but different username
        let user3:LoginViewController? = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! LoginViewController
        let _ = user3!.view
        user3!.textFieldUsername.text = "test_2"
        user3!.textFieldMobileNumber.text = "00001"
        user3!.loginButton.sendActionsForControlEvents(.TouchUpInside)
        
        XCTAssertFalse(user2!.loginButton.enabled, "login button should be enabled")
        XCTAssert(user2!.loginResult==0, "login result should be equal 0")
        
        //wait since server response need some time
        //waitForExpectationsWithTimeout(3, handler: { error in})

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
