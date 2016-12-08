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
    var dayOfWeek = [String]()
   // var dailyTemp = [Double : Double]()
    var dailyMaxTemp = [Double]()
    var dailyMinTemp = [Double]()
    
    var currentChanceOfRain = Double()
    var currentSummary = String()
    var currentTemperature = Int()
    var curentHumidity = Double()
    var currentWindSpeed = Double()
    var currentTime = Int()
    var apparentTemp = Int()
    
    var hourlyTemperature = [Double]()
    let hourlyChanceOfRain = Double()
    
    var sunsetDateString = String()
    var sunriseDateString = String()

    
    var sunset = NSDate() //change to NSDATE
    var sunrise = NSDate()
    
    func APICall(urlRequest: URL, completed: @escaping () -> ()) {
        
        
        Alamofire.request(urlRequest).responseJSON(completionHandler: {
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
        
            
            self.dailySummary = (self.daily["summary"]!.stringValue)
            let dailyData = self.daily["data"]?.arrayValue
            
            for timeAndDayData in dailyData! {
                
                let days = timeAndDayData["time"].doubleValue
                let dayDate = NSDate(timeIntervalSince1970: days)
                
                let formatter = DateFormatter()
                formatter.dateFormat = "EEEE"

                let stringDate: String = formatter.string(from: dayDate as Date)
                
                print(dayDate)
                print(stringDate)
                
                self.dayOfWeek.append(stringDate)
            }
            
            for dailyTemp in dailyData! {
                let maxTemp = dailyTemp["temperatureMax"].doubleValue
                self.dailyMaxTemp.append(maxTemp)
            }
            
            for dailyTemp in dailyData! {
                let minTemp = dailyTemp["temperatureMin"].doubleValue
                self.dailyMinTemp.append(minTemp)
            }
            
            // CURRENT
            self.currentChanceOfRain = (self.currently["precipProbability"]?.doubleValue)!
            self.currentSummary = (self.currently["summary"]?.stringValue)!
            self.currentTime = (self.currently["time"]?.intValue)!
            self.currentTemperature = Int(round((self.currently["temperature"]?.doubleValue)!))
            self.apparentTemp = Int(round((self.currently["apparentTemperature"]?.doubleValue)!))
            self.curentHumidity = (self.currently["humidity"]?.doubleValue)!
            self.currentWindSpeed = (self.currently["windSpeed"]?.doubleValue)!
            
            // Sunrise / Sunset
            let sunsetTime = (self.daily["data"]?[0]["sunsetTime"].doubleValue)!
            self.sunset = NSDate(timeIntervalSince1970: sunsetTime)
            
            let timePeriodFormatter = DateFormatter()
            timePeriodFormatter.dateFormat = "hh:mm a"
            
            self.sunsetDateString = timePeriodFormatter.string(from: self.sunset as Date)
        
            let sunriseTime = (self.daily["data"]?[0]["sunriseTime"].doubleValue)!
            self.sunrise = NSDate(timeIntervalSince1970: sunriseTime)
           
            self.sunriseDateString = timePeriodFormatter.string(from: self.sunrise as Date)
            
            
            completed()
        })
    }
//    
//    func dateConverter() {
//        guard let gregorianCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian) else {return}
//        let date = gregorianCalendar.date(from: dateComponents as DateComponents)
//        let weekday = gregorianCalendar.component(.weekday, from: date!)
//        
//        
//        switch weekday {
//        case 1:
//              "Sunday"
//        case 2:
//             "Monday"
//        case 3:
//             "Tuesday"
//        case 4:
//           "Wednesday"
//        case 5:
//            "Thursday"
//        case 6:
//            "Friday "
//        case 7:
//            "Saturday"
//        default:
//            break
//        }
//    }

    
}




