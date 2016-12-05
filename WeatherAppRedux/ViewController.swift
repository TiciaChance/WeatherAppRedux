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
    
    var weather = WeatherAPI()
    
    let locationManager = CLLocationManager()
    var locationLong = Double()
    var locationLat = Double()
    
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instantiateLocationManager()
        weather.APICall {
            self.updateUI()
            print("CITY \(self.weather.city)")
        }
    }

    
    func updateUI() {
        
        cityLbl.text = weather.city
        tempLabel.text = String(weather.currentTemperature)

    }
    
}

extension ViewController {
    
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

        print(locationLat)
        print(locationLong)
        
        
        
    }
}

