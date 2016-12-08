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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideLabels()
        instantiateLocationManager()

        let recognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeLeft(recognizer:)))
        recognizer.direction = .left
        self.view .addGestureRecognizer(recognizer)
        
    }
    
    func hideLabels() {
        cityLbl.isHidden = true
        summaryLabel.isHidden = true
        dayOfWeekLabel.isHidden = true
        tempLabel.isHidden = true
    }
    
    func showLabels() {
        cityLbl.isHidden = false
        summaryLabel.isHidden = false
        dayOfWeekLabel.isHidden = false
        tempLabel.isHidden = false

    }
    
    func swipeLeft(recognizer : UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "mySegue", sender: self)
    }
    
    
    func updateUI() {
        
        cityLbl.text = weather.city
        tempLabel.text = "\(weather.currentTemperature)°"
        summaryLabel.text = "Feels like \(weather.apparentTemp)°. It's \(weather.currentSummary.lowercased()) outside and there is \(Int(weather.currentChanceOfRain))% chance of rain."
        
        dayOfWeek()
    }
    
    func dayOfWeek() {
        
        let date1 = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date1)
        let month = calendar.component(.month, from: date1)
        let day = calendar.component(.day, from: date1)
        //let hour = calendar.component(.hour, from: date1)
        //let min = calendar.component(.month, from: date1)
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        
        let dateComponents = NSDateComponents()
        dateComponents.day =  day
        dateComponents.month = month
        dateComponents.year = year
        
        guard let gregorianCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian) else {return}
        let date = gregorianCalendar.date(from: dateComponents as DateComponents)
        let weekday = gregorianCalendar.component(.weekday, from: date!)
        
        
        switch weekday {
        case 1:
            dayOfWeekLabel.text = "Sunday \(formatter.string(from: date1))"
        case 2:
            dayOfWeekLabel.text = "Monday \(formatter.string(from: date1))"
        case 3:
            dayOfWeekLabel.text = "Tuesday \(formatter.string(from: date1))"
        case 4:
            dayOfWeekLabel.text = "Wednesday \(formatter.string(from: date1))"
        case 5:
            dayOfWeekLabel.text = "Thursday \(formatter.string(from: date1))"
        case 6:
            dayOfWeekLabel.text = "Friday \(formatter.string(from: date1))"
        case 7:
            dayOfWeekLabel.text = "Saturday \(formatter.string(from: date1))"
        default:
            break
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        let detailVC = segue.destination as! DetailVC
        
        detailVC.sunsetTime = weather.sunsetDateString
        detailVC.sunriseTime = weather.sunriseDateString
        detailVC.weekday = weather.dayOfWeek
        detailVC.minTemp = weather.dailyMinTemp
        detailVC.maxTemp = weather.dailyMaxTemp
        detailVC.dailySummary = weather.dailySummary
        detailVC.humidity = weather.curentHumidity
        detailVC.windSpeed = weather.currentWindSpeed
        detailVC.feelsLike = weather.apparentTemp
        detailVC.chanceOfRain = weather.currentChanceOfRain
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
      
        weather.APICall(urlRequest: URL(string: "\(baseURL)\(locationLat),\(locationLong)")!) {
           
            self.showLabels()
            self.updateUI()
            print(self.locationLat)

        }
        
        locationManager.stopUpdatingLocation()
    }
}

