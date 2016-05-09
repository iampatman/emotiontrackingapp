//
//  ActivityViewController.swift
//  EmotionTracking
//
//  Created by student on 5/5/16.
//  Copyright © 2016 NguyenTrung. All rights reserved.
//

import UIKit
import CoreLocation

class ActivityViewController: UIViewController,UITextFieldDelegate,CLLocationManagerDelegate{
    
    
    var returnCode: Int = 0
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var thought: UITextField!
    var emotionIdInt:Int = 0
    var long:Double = 0.0
    var lat:Double = 0.0
    var noUpdate:Int = 0
    var locationManager:CLLocationManager!
    var imageNameArray:[String] = []
    var imageViewArray:[UIImageView] = []
    
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
        //emotionIdInt = imageViewArray.indexOf(currentView)! + 1
        //currentView.image = UIImage(named: currentViewName + "_select.png")
        if (emotionIdInt == 0) {
            emotionIdInt = imageViewArray.indexOf(currentView)! + 1
            currentView.image = UIImage(named: currentViewName + "_select.png")
        }else{
            imageViewArray[emotionIdInt-1].image = UIImage(named: imageNameArray[emotionIdInt-1])
            emotionIdInt = imageViewArray.indexOf(currentView)! + 1
            currentView.image = UIImage(named: currentViewName + "_select.png")
        }
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
   
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last?.coordinate
        lat = lastLocation!.latitude
        long = lastLocation!.longitude
        noUpdate += 1
        if (noUpdate > 30) {
            locationManager.stopUpdatingLocation()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       thought.delegate = self
        userNameLabel.text = "trung"
        // Do any additional setup after loading the view, typically from a nib
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        addViewsNames()
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if (identifier == "gotoMapView"){
            AddActivities()
            return returnCode == 1
        }else if(identifier == "backtoView"){
            self.performSegueWithIdentifier("backtoView", sender: self)
            return true
        }
        return false;
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 30
        let currentgString:NSString = textField.text!
        let newString:NSString = currentgString.stringByReplacingCharactersInRange(range, withString: string)
        return newString.length <= maxLength   
    }
    
    func AddActivities() {
        let usernameStr = userNameLabel.text!
        let thoughtStr = thought.text! as String
        thought.text = thoughtStr
        
        let newActivity: Activity = Activity.init(username: usernameStr, emotionId: emotionIdInt, longitude: long, latitude: lat, thought: thoughtStr)
        DataManagement.getInstance().initDatabase()
        DataManagement.getInstance().addNewActivity(newActivity)
        
        let params = ["username":usernameStr, "emotionId":emotionIdInt, "longitude":long, "latitude":lat, "thought":thoughtStr]
        
        Utils.sendHTTPPostRequest("https://emotionstrackingapp.herokuapp.com/postActivity", params: params){(returnData: NSDictionary) in
            let resultCode: Int = (returnData["result"] as? Int)!
            self.returnCode = resultCode
            print(resultCode)
            if (resultCode == 1){
                self.performSegueWithIdentifier("gotoMapView", sender: self)
            } else {
                Utils.showMessageBox("Add activity failed", viewController: self)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}