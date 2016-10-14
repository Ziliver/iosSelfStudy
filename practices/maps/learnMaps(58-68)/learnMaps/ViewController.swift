//
//  ViewController.swift
//  learnMaps
//
//  Created by yuanzichao on 12/23/14.
//  Copyright (c) 2014 yuanzichao. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var myMap: MKMapView!
    var manager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // core location
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
        
        
        //sample code of setting a coordinate
//        39.441958, -119.824155
//        var lattitude:CLLocationDegrees = 39.441958
//        var longitude:CLLocationDegrees = -119.824155
//        var latdelta:CLLocationDegrees = 0.01
//        var londelta:CLLocationDegrees = 0.01
//        var span:MKCoordinateSpan = MKCoordinateSpanMake(latdelta, londelta)
//        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lattitude, longitude)
//        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
//        myMap.setRegion(region, animated: true)
//        var annotation = MKPointAnnotation()
//        annotation.coordinate = location
//        annotation.title = "Statue of liberty"
//        annotation.subtitle = "One day, I will go there"
//        myMap.addAnnotation(annotation)
        var uilongpress = UILongPressGestureRecognizer(target: self, action: "action:")
        uilongpress.minimumPressDuration = 1.0
        myMap.addGestureRecognizer(uilongpress)
    }

    func action(gestureRecognizer:UIGestureRecognizer){
        var touchPoint = gestureRecognizer.locationInView(self.myMap)
        var newCoordinate: CLLocationCoordinate2D = myMap.convertPoint(touchPoint, toCoordinateFromView: myMap)
        var newAnnotation = MKPointAnnotation()
        newAnnotation.coordinate = newCoordinate
        newAnnotation.title = "new point"
        newAnnotation.subtitle = "some description"
        myMap.addAnnotation(newAnnotation)

    }
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
//        print()
//        print("\n location = \(locations)")
//        use debug and simulate the devices such as city ride
        
        var userLocation = locations[0] as CLLocation
        
//        println(userLocation.coordinate.longitude)
        
        
        /* real time location tracking*/
        var lattitude:CLLocationDegrees = userLocation.coordinate.latitude
        var longitude:CLLocationDegrees = userLocation.coordinate.longitude
        var latdelta:CLLocationDegrees = 0.01
        var londelta:CLLocationDegrees = 0.01
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latdelta, londelta)
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lattitude, longitude)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        myMap.setRegion(region, animated: true)

        
        
        
    }
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        print(error)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

