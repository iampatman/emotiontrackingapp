//
//  ActivityViewController.swift
//  EmotionTracking
//
//  Created by student on 5/5/16.
//  Copyright © 2016 NguyenTrung. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController,UITextFieldDelegate {
    
    
    var returnCode: Int = 0
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var thought: UITextField!
    var emotionIdInt:Int = 0
   // var imageViewArray:[UIImageView] = []
    
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
    
//    func tapViews(image:UIImageView, imageName:String, emotionId:Int)  {
//        emotionIdInt = imageViewArray.indexOf(image)! + 1
//        image.image = UIImage(named: imageName+"_select.png")
//        //image.
//    }
   
//    func addViews()  {
//        imageViewArray.append(excitedImage)
//        imageViewArray.append(happyImage)
//        imageViewArray.append(apatheticImage)
//        imageViewArray.append(sadImage)
//        imageViewArray.append(angryImage)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       thought.delegate = self
        userNameLabel.text = "trung"
        // Do any additional setup after loading the view, typically from a nib
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
        let long: Double = 103.776611
        let lat: Double = 1.292516
        let thoughtStr = thought.text! as String
        thought.text = thoughtStr
        
        let newActivity: Activity = Activity.init(username: usernameStr, emotionId: emotionIdInt, longitude: long, latitude: lat, thought: thoughtStr)
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