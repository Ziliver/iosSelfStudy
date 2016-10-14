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
    
    
    var manager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var userLocation:CLLocation = locations[0] as CLLocation

        println(userLocation)
        latitude.text = "\(userLocation.coordinate.latitude)"
        longitude.text = "\(userLocation.coordinate.longitude)"
        course.text = "\(userLocation.course)"
        //  course returns the speed of the location in m/s. Negative if speed is invalid.
        speed.text = "\(userLocation.speed)"
        altitude.text = "\(userLocation.altitude)"
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: {
            (placemarks,error) in
            if ((error) != nil) {println("\(error)")}
            else
            {
                
                let p = CLPlacemark(placemark: placemarks?[0] as CLPlacemark)
                
//                find the info of the CLPlacemark
//                println("\(p)")
                
                self.address.text = " \(p.subAdministrativeArea) \n \(p.subLocality) \n \(p.subThoroughfare) \n\(p.locality)"
            }
            
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

