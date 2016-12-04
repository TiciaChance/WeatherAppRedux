//
//  WeatherAPI.swift
//  WeatherAppRedux
//
//  Created by Laticia Chance on 11/30/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherAPI: NSObject {
    
    let baseURL = "https://api.darksky.net/forecast/4f9f733e45e297b9118dc052b51e101f/"
    
    var city = String()
    var country = String()
    var longitude = Double()
    var latitude = Double()
    
    var daily = [String : JSON]()
    var currently = [String : JSON]()
    var hourly = [String : JSON]()
    
    var dailySummary = String()
    
    var currentChanceOfRain = Double()
    var currentSummary = String()
    var currentTemperature = Double()
    var curentHumidity = Double()
    var currentWindSpeed = Double()
    
    var hourlyTemperature = Double()
    let hourlyChanceOfRain = Double()
    
    var sunset = Int() //change to NSDATE
    var sunrise = Int()
    
    
    func APICall(urlRequest: URL) {
        
        Alamofire.request(urlRequest).responseJSON { (response) in
            
            //guard let weather = JSON(data: response.data!).dictionary else {return}
            
        }
        
    }
    
//    func getWeatherByCity(city: String) {
//        let weatherRequestURL = URL(string: "\(baseURL)\(latitude)\(longitude)")
//        APICall(urlRequest: weatherRequestURL!)
//    }
 
    func getWeatherByCoordinates(latitude: Double, longitude: Double) {
        let weatherRequestURL = URL(string: "\(baseURL)\(latitude)\(longitude)")!
        APICall(urlRequest: weatherRequestURL)
    }

}
