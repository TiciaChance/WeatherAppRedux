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
    
    var city = String()
    var country = String()
    var longitude = Double()
    var latitude = Double()
    
    var DailySummary = String()
    var currently = [String : JSON]()
    var hourly = [String : JSON]()
    
    
    func APICall(urlRequest: URL) {
        
        Alamofire.request("https://api.darksky.net/forecast/4f9f733e45e297b9118dc052b51e101f/40.3601,-74.0589").responseJSON { (response) in
            
            guard let weather = JSON(data: response.data!).dictionary else {return}
            
            self.currently = (weather["currently"]?.dictionaryValue)!
            self.hourly = (weather["hourly"]?.dictionaryValue)!
            
            //print("\n\n\n\nTHIS IS CURRENTLY \(self.currently)")
            //print("\n\n\n\nTHIS IS HOURLY \(self.hourly)")


        }
        
        
    }

}
