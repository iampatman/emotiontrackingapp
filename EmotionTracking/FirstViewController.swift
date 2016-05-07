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

class FirstViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var activitiesList: [NSDictionary]?
    var username: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.asfdasf
        NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: #selector(self.updateMap),userInfo: self,repeats: true)
               
        let long: Double = 103.776611312312
        let lat: Double = 1.292516
        let position: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: (lat as? CLLocationDegrees)!, longitude: (long as? CLLocationDegrees)!)
        self.annotateMap(position)

 
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }

    func initMapView(){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateMap(){
        print("call json")
        let params = [:]
        Utils.sendHTTPPostRequest("https://emotionstrackingapp.herokuapp.com/listActivities", params: params){
            (returnJSON: NSDictionary) in
            //print(returnJSON["list"])
            self.activitiesList = returnJSON["list"] as? [NSDictionary]
            
    //        for activity in self.activitiesList! {
                //print(activity["location"]!)
                //Show pin on the map based on these values
                
       //     }
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
        homePin.title = "Some one status"
        self.mapView.addAnnotation(homePin)
        
    }

    
    
    
    

}

