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
    var emotionIdInt:Int = 0
    var long:Double = 0.0
    var lat:Double = 0.0
    var username: String = ""
    var locationManager: CLLocationManager!
    @IBOutlet weak var excitedImage: UIImageView!
    @IBOutlet weak var happyImage: UIImageView!
    @IBOutlet weak var apatheticImage: UIImageView!
    @IBOutlet weak var sadImage: UIImageView!
    @IBOutlet weak var angryImage: UIImageView!
    

    @IBAction func excitedTap(sender: AnyObject) {
        emotionIdInt = 1
        // excitedImage.image = imageViewArray[x]
        excitedImage.image = UIImage(named: "excited_select.png" )
        happyImage.image = UIImage(named: "happy_normal.png")
        apatheticImage.image = UIImage(named: "apathetic_normal.png")
        sadImage.image = UIImage(named: "sad_normal.png")
        angryImage.image = UIImage(named: "angry_normal.png")
    }
    
    @IBAction func happyTap(sender: AnyObject) {
        emotionIdInt = 2
        happyImage.image = UIImage(named: "happy_select.png" )
        excitedImage.image = UIImage(named: "excited_normal.png")
        apatheticImage.image = UIImage(named: "apathetic_normal.png")
        sadImage.image = UIImage(named: "sad_normal.png")
        angryImage.image = UIImage(named: "angry_normal.png")
    }
    
    @IBAction func apatheticTap(sender: AnyObject) {
        emotionIdInt = 3
        apatheticImage.image = UIImage(named: "apathetic_select.png")
        excitedImage.image = UIImage(named: "excited_normal.png")
        happyImage.image = UIImage(named: "happy_normal.png")
        sadImage.image = UIImage(named: "sad_normal.png")
        angryImage.image = UIImage(named: "angry_normal.png")
    }
    
    @IBAction func sadTap(sender: AnyObject) {
        emotionIdInt = 4
        sadImage.image = UIImage(named: "sad_select.png")
        excitedImage.image = UIImage(named: "excited_normal.png")
        happyImage.image = UIImage(named: "happy_normal.png")
        apatheticImage.image = UIImage(named: "apathetic_normal.png")
        angryImage.image = UIImage(named: "angry_normal.png")
    }
    
    @IBAction func angryTap(sender: AnyObject) {
        //tapViews(angryImage, imageName: "angry", emotionId: emotionIdInt)
        emotionIdInt = 5
        angryImage.image = UIImage(named: "angry_select.png")
        happyImage.image = UIImage(named: "happy_normal.png")
        sadImage.image = UIImage(named: "sad_normal.png")
        apatheticImage.image = UIImage(named: "apathetic_normal.png")
        sadImage.image = UIImage(named: "sad_normal.png")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        thought.delegate = self
       
        // Do any additional setup after loading the view, typically from a nib
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
    }
    
    override func viewDidAppear(animated: Bool) {
        lat = 0
        long = 0
        excitedTap(self)
        locationManager.startUpdatingLocation()
        print("start getting location")
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
        if (lat != 0 && long != 0) {
            locationManager.stopUpdatingLocation()
            print("Stop getting location")
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if (identifier == "gotoMapView"){
            return returnCode == 1
        }
        return true;
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 15
        let currentgString:NSString = textField.text!
        let newString:NSString = currentgString.stringByReplacingCharactersInRange(range, withString: string)
        return newString.length <= maxLength
    }
    
    @IBAction func createActivities(sender: AnyObject) {
        thought.resignFirstResponder()
        self.postButton.enabled = false
        self.activityIndicator.startAnimating()
        let thoughtStr = thought.text! as String
        //thought.text = thoughtStr
        
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
                
                self.performSegueWithIdentifier("backToMap", sender: self)
            } else {
                Utils.showMessageBox("Add activity failed", viewController: self)
            }
        }
    }
    @IBAction func checkFBAcount(sender: AnyObject) {
        if (SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) == false){
            Utils.showMessageBox("No Facebook account found on device", viewController: self)
            shareFB.setOn(false, animated: true)

        } else {
            self.shareToFacebook()
        }
    }
    func shareToFacebook(){
        if (SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook)){
            let thoughtStr = thought.text! as String

            let controller = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            
            print(controller.setInitialText(thoughtStr))
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "postActivity"){
            createActivities(sender!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}