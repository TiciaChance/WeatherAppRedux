//
//  ViewController.swift
//  WeatherAppRedux
//
//  Created by Laticia Chance on 11/30/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    let weather = WeatherAPI()
    var location = LocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        location.instantiateLocationManager()
        weather.APICall(urlRequest: URL(string: "https://api.darksky.net/forecast/4f9f733e45e297b9118dc052b51e101f/40.3601,-74.0589")!)
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

