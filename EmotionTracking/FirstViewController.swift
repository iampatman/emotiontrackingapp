//
//  FirstViewController.swift
//  EmotionTracking
//
//  Created by student on 3/5/16.
//  Copyright © 2016 NguyenTrung. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FirstViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate
{
    @IBOutlet weak var progressView: UIProgressView!
    var counter:Int = 0 {
        didSet {
            let fractionalProgress = Float(counter) / 100.0
            let animated = counter != 0
            progressView.setProgress(fractionalProgress, animated: animated)
        }
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    //var coordinate1: CLLocationCoordinate2D = CLLocationCoordinate2D()
    //var currentAnnotation: MKPointAnnotation?
    
    var location : LocationObject!
    var username: String = ""
    //For current location
    var locationManager:CLLocationManager!
    let regionRadius: CLLocationDistance = 2000
    
    //List of nearby users
    var locationsResult = [LocationObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       NSTimer.scheduledTimerWithTimeInterval(30.0, target: self, selector: #selector(self.updateMap),userInfo: self,repeats: true)
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        //Receive JSON data and Annotate locations
        //initialData()
        
        mapView.showsUserLocation = true
        mapView.userLocation.title = "You are here"
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        //mapView.userTrackingMode = MKUserTrackingMode.FollowWithHeading
        mapView.delegate = self
        mapView.reloadInputViews()
    }
    
    override func viewDidAppear(animated: Bool) {
        //mapView.showsUserLocation = true
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        mapView.reloadInputViews()
        self.updateMap()
    }

    /*
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last?.description as String!
        print("locations = \(lastLocation)")
        
        if let location1: CLLocation = manager.location {
            centerMapOnLocation(location1)
            if (currentAnnotation != nil){
                mapView.removeAnnotation(currentAnnotation!)
            }
            coordinate1 = location1.coordinate
            self.annotateMap(coordinate1)
            //locationManager.stopUpdatingLocation();
            // ... proceed with the location and coordintes
        }
    }*/
    
    /*
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }*/
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        self.updateMap()
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let annotation = annotation as? LocationObject {
            let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            //pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            //    let filename = Utils.emotionImagesFileName[0] + "_normal"
            //   pin.image = UIImage(named: filename)
            pin.canShowCallout = true
            pin.animatesDrop = true
            pin.rightCalloutAccessoryView = UIButton.init(type: .DetailDisclosure) as UIView
            pin.pinTintColor = annotation.pinTintColor()
            
            return pin
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        
        location = view.annotation as! LocationObject
        self.performSegueWithIdentifier("showLocationDetail", sender: self)
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue,
                                  sender: AnyObject?){
        if (segue.identifier == "showLocationDetail"){
            if let controller = (segue.destinationViewController as! UINavigationController).viewControllers[0] as? DetailLocationView {
                controller.location = location
            }
        }
        if (segue.identifier == "postActivity"){
            if let controller = (segue.destinationViewController as! UINavigationController).viewControllers[0] as? ActivityViewController {
                controller.username = self.username
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func processViewRunning(){
        self.counter = 0
        for _ in 0..<100 {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
                sleep(1)
                dispatch_async(dispatch_get_main_queue(), {
                    self.counter += 1
                    return
                })
            })
        }
    }
    
    func updateMap(){
        if (Utils.testReachability(self)==false){
            return
        }
        processViewRunning()
     //   self.locationManager.startUpdatingLocation()
        print("call json")
        let params = [:]
        Utils.sendHTTPPostRequest("https://emotionstrackingapp.herokuapp.com/listActivities", params: params){
            (returnJSON: NSDictionary) in
            //print(returnJSON["list"])
            if let activitiesList = returnJSON["list"] as? [NSDictionary]{
                self.mapView.removeAnnotations(self.locationsResult)
                self.locationsResult.removeAll()
                for activity in activitiesList {
                    let emotionId: Int? = activity["emotionId"] as AnyObject? as? Int
                    if (emotionId == nil || emotionId < 1 || emotionId > 5){
                        continue
                    }
                    self.locationsResult.append(LocationObject(title: Utils.emotionList[((activity["emotionId"] as AnyObject? as? Int) ?? 0) - 1 ] ?? "", subtitle: (activity["thought"] as AnyObject? as? String) ?? "",username: (activity["username"] as AnyObject? as? String) ?? "", latitude: (activity["latitude"] as AnyObject? as? Double) ?? 1.294455, longitude: (activity["longitude"] as AnyObject? as? Double) ?? 103.7829, time: (activity["time"] as AnyObject? as? NSDate) ?? NSDate(), mobileNumber: (activity["mobilephone"] as AnyObject? as? String) ?? ""))
                    //Show pin on the map based on these values
                    
                }
                
                self.mapView.addAnnotations(self.locationsResult)
                self.progressView.setProgress(0, animated: true)
                
            }
        }
        
    }
    
    func annotateMap(coordinate: CLLocationCoordinate2D){
        let latDelta: CLLocationDegrees = 0.01
        let longDelta: CLLocationDegrees = 0.01
        let theSpan: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        let newLocation: CLLocationCoordinate2D = coordinate
        let theRegion: MKCoordinateRegion = MKCoordinateRegionMake(newLocation, theSpan)
        self.mapView.setRegion(theRegion, animated: false)
        self.mapView.mapType = .Standard
        let homePin = MKPointAnnotation()
        homePin.coordinate = coordinate
        homePin.title = "I am here"
        //currentAnnotation = homePin
        self.mapView.addAnnotation(homePin)
    }
    
    func initialData() {
        locationsResult.append(LocationObject(title: "Happy", subtitle: "I AM HAPPY",username: "user1", latitude: 1.29167724, longitude: 103.77683571, time: NSDate(), mobileNumber: "6599998888"))
        
        locationsResult.append(LocationObject(title: "Sad", subtitle: "I AM SAD", username: "user2", latitude: 1.294455, longitude: 103.7829, time: NSDate(), mobileNumber: "6577774444"))
        
        self.mapView.addAnnotations(self.locationsResult)
    }
    
    @IBAction func cancelToActivityViewController(segue:UIStoryboardSegue) {
        
    }
    
    
    
    
    
}
