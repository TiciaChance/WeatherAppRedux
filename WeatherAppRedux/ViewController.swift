//
//  ViewController.swift
//  WeatherAppRedux
//
//  Created by Laticia Chance on 11/30/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let weather = WeatherAPI()

    let locationManager = CLLocationManager()
    var locationLong = Double()
    var locationLat = Double()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instantiateLocationManager()
        weather.APICall(urlRequest: URL(string: "https://api.darksky.net/forecast/4f9f733e45e297b9118dc052b51e101f/51.5074,0.1278")!)
        
    }
    
   
    func instantiateLocationManager() {
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]
        locationLong = userLocation.coordinate.longitude
        locationLat = userLocation.coordinate.latitude
        
        weather.getWeatherByCoordinates(latitude: locationLat, longitude: locationLong)
        
        print(locationLat)
        print(locationLong)
        
    }
    
}

