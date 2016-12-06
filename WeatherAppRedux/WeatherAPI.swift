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
    
    var hourlyData = [[String : AnyObject]]()
    
    var daily = [String : JSON]()
    var currently = [String : JSON]()
    var hourly = [String : AnyObject]()
    
    var dailySummary = String()
    
    var currentChanceOfRain = Double()
    var currentSummary = String()
    var currentTemperature = Int()
    var curentHumidity = Double()
    var currentWindSpeed = Double()
    var currentTime = Int()
    
    var hourlyTemperature = [Double]()
    let hourlyChanceOfRain = Double()
    
    var sunset = Int() //change to NSDATE
    var sunrise = Int()
    
    func APICall(completed: @escaping () -> ()) {
        
        
        Alamofire.request("https://api.darksky.net/forecast/4f9f733e45e297b9118dc052b51e101f/40,-74").responseJSON(completionHandler: {
            response in
            
            guard let weather = JSON(data: response.data!).dictionary else {return}
            
            let weather2 = response.result.value as! [String : AnyObject]
            
            let timezone = weather["timezone"]?.stringValue
            let countryCity = timezone?.components(separatedBy: "/")
            self.country = (countryCity?[0])!
            self.city = (countryCity?[1].replacingOccurrences(of: "_", with: " "))!

            
            self.daily = (weather["daily"]?.dictionaryValue)!
            self.currently = (weather["currently"]?.dictionaryValue)!
            self.hourly = weather2["hourly"] as! [String : AnyObject]
            
            self.hourlyData = self.hourly["data"] as! [[String : AnyObject]]
            
            
            for dict in self.hourlyData {
                
                self.hourlyTemperature.append(dict["temperature"] as! Double)
                //print(" \n\n\n\nHEY ::: \(self.hourlyTemperature)")
            }
            
            self.dailySummary = (self.daily["data"]?["summary"].stringValue)!
            
            self.currentChanceOfRain = (self.currently["precipProbability"]?.doubleValue)!
            self.currentSummary = (self.currently["summary"]?.stringValue)!
            self.currentTime = (self.currently["time"]?.intValue)!
            self.currentTemperature = Int(round((self.currently["temperature"]?.doubleValue)!))
            
            self.curentHumidity = (self.currently["humidity"]?.doubleValue)!
            self.currentWindSpeed = (self.currently["windSpeed"]?.doubleValue)!
            
            //self.hourlyTemperature = (self.hourly["data"]![0]["temperature"].doubleValue)
            
            self.sunset = (self.daily["data"]?[0]["sunsetTime"].intValue)!
            self.sunrise = (self.daily["data"]?[0]["sunriseTime"].intValue)!
            
            
            //print("\n\n\n\nTHIS IS CURRENTLY \(self.city)")
            //print("\n\n\n\nTHIS IS HOURLY \(self.hourly)")
            
            completed()
        })
    }
    
}




