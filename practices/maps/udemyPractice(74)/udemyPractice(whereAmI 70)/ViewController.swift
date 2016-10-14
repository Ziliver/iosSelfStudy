//
//  ViewController.swift
//  udemyPractice(whereAmI 70)
//
//  Created by yuanzichao on 12/23/14.
//  Copyright (c) 2014 yuanzichao. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var course: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var myMap: MKMapView!
    @IBAction func findMe(sender: AnyObject) {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    var manager:CLLocationManager!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "back"{
            self.navigationController?.navigationBarHidden = false
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        if activePlace == -1 {
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        }
        
        else{
            
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let lat = NSString(string: places[activePlace]["lat"]!).doubleValue
        let lon = NSString(string: places[activePlace]["lon"]!).doubleValue
        
        var latitude: CLLocationDegrees = lat
        var longtitude: CLLocationDegrees = lon
        var latDelta: CLLocationDegrees = 0.01
        var lonDelta: CLLocationDegrees = 0.01
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longtitude)
        var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        myMap.setRegion(region, animated: true)
        
//        println(activePlace)
            
            var annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = places[activePlace]["name"]
            myMap.addAnnotation(annotation)
        }
            var longpress = UILongPressGestureRecognizer(target: self, action: "action:")
            longpress.minimumPressDuration =  1.0
            myMap.addGestureRecognizer(longpress)
        

    }

    func action(gestureRecognizer:UIGestureRecognizer){
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began{
//        println("hi")
        var touchPoint = gestureRecognizer.locationInView(self.myMap)
        var newCoordinate = myMap.convertPoint(touchPoint, toCoordinateFromView: self.myMap)
        var loc = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
        
        CLGeocoder().reverseGeocodeLocation(loc, completionHandler: {
            (placemarks,error) in
            if ((error) != nil) {println("\(error)")}
            else
            {
                
                let p = CLPlacemark(placemark: placemarks?[0] as CLPlacemark)
        var annotation = MKPointAnnotation()
        annotation.coordinate = newCoordinate
        annotation.title = "\(p.subThoroughfare)\(p.thoroughfare)"
        self.myMap.addAnnotation(annotation)
            
        places.append(["name":"\(p.subThoroughfare)\(p.thoroughfare)","lat":"\(newCoordinate.latitude)","lon":"\(newCoordinate.longitude)"])
            }
            
        })
    }
}
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var userLocation:CLLocation = locations[0] as CLLocation

//        println(userLocation)
//        userLocation.coordinate.latitude
//        userLocation.coordinate.longitude
        
        var latitude: CLLocationDegrees =  userLocation.coordinate.latitude
        var longtitude: CLLocationDegrees = userLocation.coordinate.longitude
        var latDelta: CLLocationDegrees = 0.01
        var lonDelta: CLLocationDegrees = 0.01
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longtitude)
        var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        myMap.setRegion(region, animated: true)
        
        manager.stopUpdatingLocation()
        
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  

}

