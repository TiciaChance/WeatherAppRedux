//
//  ViewController.swift
//  WeatherAppRedux
//
//  Created by Laticia Chance on 11/30/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var weather = WeatherAPI()
    let baseURL = "https://api.darksky.net/forecast/4f9f733e45e297b9118dc052b51e101f/"

    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var locationLong = Double()
    var locationLat = Double()
    
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.clear
        
        tableView.dataSource = self
        tableView.delegate = self
        
        instantiateLocationManager()

        weather.APICall(completed: {
          self.updateUI()
        })
        
    }
    
    
    func updateUI() {
        
        cityLbl.text = weather.city
        tempLabel.text = "\(weather.currentTemperature)°"

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = "\(weather.hourlyTemperature)"
        
        return cell
    }
    
    
//    func getWeatherByCoordinates(latitude: Double, longitude: Double) {
//        let weatherRequestURL = URL(string: "\(weather.baseURL)\(latitude)\(longitude)")!
//        weather.APICall(urlRequest: weatherRequestURL, completed: {
//            print(self.locationLong)
//        })
//    }
    
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

        //print(locationLat)
        //print(locationLong)
                
    }
}

