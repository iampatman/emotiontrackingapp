//
//  ActivityViewController.swift
//  EmotionTracking
//
//  Created by student on 5/5/16.
//  Copyright © 2016 NguyenTrung. All rights reserved.
//

import UIKit
import CoreLocation
import Social
class ActivityViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var postButton: UIBarButtonItem!
    @IBOutlet weak var shareFB: UISwitch!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var returnCode: Int = 0
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var thought: UITextField!
    var emotionIdInt:Int = 1
    var long:Double = 0.0
    var lat:Double = 0.0
    var username: String = ""
    var locationManager: CLLocationManager!
    var imageNameArray:[String] = []
    var imageViewArray:[UIImageView] = []
    var posted: Bool = false
    @IBOutlet weak var excitedImage: UIImageView!
    @IBOutlet weak var happyImage: UIImageView!
    @IBOutlet weak var apatheticImage: UIImageView!
    @IBOutlet weak var sadImage: UIImageView!
    @IBOutlet weak var angryImage: UIImageView!
    

    @IBAction func excitedTap(sender: AnyObject) {
        tapViews(excitedImage, currentViewName: "excited")
    }
    
    @IBAction func happyTap(sender: AnyObject) {
        tapViews(happyImage, currentViewName: "happy")
    }
    
    @IBAction func apatheticTap(sender: AnyObject) {
        tapViews(apatheticImage, currentViewName: "apathetic")
    }
    
    @IBAction func sadTap(sender: AnyObject) {
       tapViews(sadImage, currentViewName: "sad")
    }
    
    @IBAction func angryTap(sender: AnyObject) {
        tapViews(angryImage, currentViewName: "angry")
    }
    
    func tapViews(currentView:UIImageView,currentViewName:String)  {
        imageViewArray[emotionIdInt-1].image = UIImage(named: imageNameArray[emotionIdInt-1])
        emotionIdInt = imageViewArray.indexOf(currentView)! + 1
        currentView.image = UIImage(named: currentViewName + "_select.png")
    }
    
    func addViewsNames()  {
        imageNameArray.append("excited_normal.png")
        imageNameArray.append("happy_normal.png")
        imageNameArray.append("sad_normal.png")
        imageNameArray.append("apathetic_normal.png")
        imageNameArray.append("angry_normal.png")
        imageViewArray.append(excitedImage)
        imageViewArray.append(happyImage)
        imageViewArray.append(sadImage)
        imageViewArray.append(apatheticImage)
        imageViewArray.append(angryImage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        thought.delegate = self
       
        // Do any additional setup after loading the view, typically from a nib
        addViewsNames()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100
        locationManager.requestAlwaysAuthorization()
        lat = 0
        long = 0
    }
    
    override func viewDidAppear(animated: Bool) {
        excitedTap(self)
        locationManager.startUpdatingLocation()
        print("start getting location")
    }
    
    override func viewWillDisappear(animated: Bool) {
        print("Stop getting location")
        locationManager.stopUpdatingLocation()
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last?.coordinate
        lat = lastLocation!.latitude
        long = lastLocation!.longitude
        print("lat: \(lat)")
        print("long: \(long)")
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if (identifier == "gotoMapView"){
            return returnCode == 1
        }
        return true;
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 100
        let currentgString:NSString = textField.text!
        let newString:NSString = currentgString.stringByReplacingCharactersInRange(range, withString: string)
        return newString.length <= maxLength
    }
    
    @IBAction func createActivities(sender: AnyObject) {

        thought.resignFirstResponder()
        if (Utils.testReachability(self)==false){
            return
        }
        self.postButton.enabled = false
        self.activityIndicator.startAnimating()
        let thoughtStr = thought.text! as String
        
        if (thoughtStr == "") {
            Utils.showMessageBox("Your input is empty, please add your thought", viewController: self)
            self.postButton.enabled = true
            return
        }
        
        let newActivity: Activity = Activity(username: username, emotionId: emotionIdInt, longitude: long, latitude: lat, thought: thoughtStr)
        DataManagement.getInstance().addNewActivity(newActivity)
        
        let params = ["username": username, "emotionId":emotionIdInt, "longitude":long, "latitude":lat, "thought":thoughtStr]

        Utils.sendHTTPPostRequest("https://emotionstrackingapp.herokuapp.com/postActivity", params: params){(returnData: NSDictionary) in
            let resultCode: Int = (returnData["result"] as? Int)!
            self.returnCode = resultCode
            print(resultCode)
            self.activityIndicator.stopAnimating()
            self.thought.text = ""
            self.postButton.enabled = true

            if (resultCode == 1){
                self.posted = true
                self.performSegueWithIdentifier("backToMap", sender: self)
            } else {
                Utils.showMessageBox("Add activity failed", viewController: self)
            }
        }
    }
    @IBAction func checkFBAcount(sender: AnyObject) {
        if (!shareFB.on){
            return;
        }
        if (SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) == false){
            Utils.showMessageBox("No Facebook account found on device", viewController: self)
            shareFB.setOn(false, animated: true)

        } else {
            self.shareToFacebook()
        }
    }
    func shareToFacebook(){
        if (SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook)){
         //   let thoughtStr = thought.text! as String

            let controller = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            
            print(controller.setInitialText("Hello Trung ne"))
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "postActivity"){
            createActivities(sender!)
        }
        if (segue.identifier == "backToMap"){
            if let mainMap = segue.destinationViewController as? FirstViewController {
                mainMap.reloadMapNeeded = self.posted
                self.posted = false
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}