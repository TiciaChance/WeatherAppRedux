//
//  Weather.swift
//  WeatherAppRedux
//
//  Created by Laticia Chance on 12/3/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import Foundation

struct Weather {
    
    let weatherData : [String: AnyObject]
    
    var city : String
    var country : String
    //var longitude : Double
    //var latitude : Double
    
    var daily : [String : AnyObject]
    var currently : [String : AnyObject]
    var hourly : [[String : AnyObject]]
    
    var dailySummary : String
    
    var currentChanceOfRain : Double
    var currentSummary : String
    var currentTemperature : Double
    var curentHumidity : Double
    var currentWindSpeed : Double
    
    var hourlyTemperature : Double
    let hourlyChanceOfRain : Double
    
    var sunset = Int() //change to NSDATE
    var sunrise = Int()
    
    init(weatherData: [String : AnyObject]) {
        
        self.weatherData = weatherData
        
        let timezone = weatherData["timezone"]?.stringValue
        let countryCity = timezone?.components(separatedBy: "/")
        self.country = (countryCity?[0])!
        self.city = (countryCity?[1])!
        
        self.daily = weatherData["daily"] as! [String : AnyObject]
        self.currently = weatherData["currently"] as! [String : AnyObject]
        self.hourly = weatherData["hourly"]!["data"] as! [[String: AnyObject]]
        
        self.dailySummary = self.daily["data"]?["summary"] as! String
        
        self.currentChanceOfRain = self.currently["precipProbability"] as! Double
        self.currentSummary = self.currently["summary"] as! String
        self.currentTemperature = self.currently["temperature"] as! Double
        self.curentHumidity = self.currently["humidity"] as! Double
        self.currentWindSpeed = self.currently["windSpeed"] as! Double
        
        self.hourlyTemperature = 90.0
        self.hourlyChanceOfRain = 7.0
        self.sunrise = 0
        self.sunset = 8
        
        self.hourlyTemperature = self.hourly[0]["temperature"] as! Double
        
        let dailyArray = self.daily["data"] as! [[String : AnyObject]]
        self.sunset = dailyArray[0]["sunsetTime"] as! Int //update to NSDate
        self.sunrise = dailyArray[0]["sunriseTime"] as! Int //update to NSDate
        
    }
    
}
