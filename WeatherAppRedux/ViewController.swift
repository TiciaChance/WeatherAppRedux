//
//  ViewController.swift
//  WeatherAppRedux
//
//  Created by Laticia Chance on 11/30/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var weather = WeatherAPI()
    let baseURL = "https://api.darksky.net/forecast/4f9f733e45e297b9118dc052b51e101f/"
    
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    let locationManager = CLLocationManager()
    var locationLong = Double()
    var locationLat = Double()
    
    var time = String()
    var test = String()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instantiateLocationManager()

        let recognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeLeft(recognizer:)))
        recognizer.direction = .left
        self.view .addGestureRecognizer(recognizer)
        
    }
    
    
    
    func swipeLeft(recognizer : UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "mySegue", sender: self)
    }
    
    
    func updateUI() {
        
        cityLbl.text = weather.city
        tempLabel.text = "\(weather.currentTemperature)°"
        summaryLabel.text = "Feels like \(weather.apparentTemp)°. It's \(weather.currentSummary) outside and there is \(Int(weather.currentChanceOfRain))% chance of rain."
        
        dayOfWeek()
        
    }
    
    func dayOfWeek() {
        
        let date1 = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date1)
        let month = calendar.component(.month, from: date1)
        let day = calendar.component(.day, from: date1)
        let hour = calendar.component(.hour, from: date1)
        let min = calendar.component(.month, from: date1)
        
        
        let dateComponents = NSDateComponents()
        dateComponents.day =  day
        dateComponents.month = month
        dateComponents.year = year
        
        guard let gregorianCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian) else {return}
        let date = gregorianCalendar.date(from: dateComponents as DateComponents)
        let weekday = gregorianCalendar.component(.weekday, from: date!)
        
        
        switch weekday {
        case 1:
            dayOfWeekLabel.text = "Sunday \(hour):\(min)"
        case 2:
            dayOfWeekLabel.text = "Monday \(hour):\(min)"
        case 3:
            dayOfWeekLabel.text = "Tuesday \(hour):\(min)"
        case 4:
            dayOfWeekLabel.text = "Wednesday \(hour):\(min)"
        case 5:
            dayOfWeekLabel.text = "Thursday \(hour):\(min)"
        case 6:
            dayOfWeekLabel.text = "Friday \(hour):\(min)"
        case 7:
            dayOfWeekLabel.text = "Saturday \(hour):\(min)"
        default:
            break
        }
        
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
      
        print("getting location")
        print(locationLong)
       // print(locationLat)
        weather.APICall(urlRequest: URL(string: "\(baseURL)\(locationLat),\(locationLong)")!) {
            print("getting data and lat = \(self.locationLat)")
            print(" long = \(self.locationLong)")
            self.updateUI()

        }
        
        locationManager.stopUpdatingLocation()
    }
}

