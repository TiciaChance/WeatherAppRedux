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
    let baseURL = "https://api.darksky.net/forecast/4f9f733e45e297b9118dc052b51e101f/"

    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    let locationManager = CLLocationManager()
    var locationLong = Double()
    var locationLat = Double()
    
    var time = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instantiateLocationManager()

        weather.APICall(completed: {
          self.updateUI()
        })
        
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
        summaryLabel.text = weather.currentSummary
        
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
        
        time = "\(hour):\(min)"
        timeLabel.text = time

        
        let dateComponents = NSDateComponents()
        dateComponents.day =  day
        dateComponents.month = month
        dateComponents.year = year
        
        guard let gregorianCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian) else {return}
            let date = gregorianCalendar.date(from: dateComponents as DateComponents)
            let weekday = gregorianCalendar.component(.weekday, from: date!)
            print(weekday) // 5, which corresponds to Thursday in the Gregorian Calendar
        
        
        switch weekday {
        case 1:
            dayOfWeekLabel.text = "Sunday"
        case 2:
            dayOfWeekLabel.text = "Monday"
        case 3:
            dayOfWeekLabel.text = "Tuesday"
        case 4:
            dayOfWeekLabel.text = "Wednesday"
        case 5:
            dayOfWeekLabel.text = "Thursday"
        case 6:
            dayOfWeekLabel.text = "Friday"
        case 7:
            dayOfWeekLabel.text = "Saturday"
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

        //print(locationLat)
        //print(locationLong)
                
    }
}

