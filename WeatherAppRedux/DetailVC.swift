//
//  DetailVC.swift
//  WeatherAppRedux
//
//  Created by Laticia Chance on 12/6/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import UIKit

class DetailVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var sunriseLabel: UILabel!
    
    @IBOutlet weak var sunsetLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dailySumLabel: UILabel!
    
    @IBOutlet weak var humidtyLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    @IBOutlet weak var chanceOfRainLabel: UILabel!
    
    @IBOutlet weak var feelsLikeLabel: UILabel!
    
    var sunriseTime = String()
    var sunsetTime = String()
    var humidity = Double()
    var windSpeed = Double()
    var weekday = [String]()
    var minTemp = [Double]()
    var maxTemp = [Double]()
    var dailySummary = String()
    var chanceOfRain = Double()
    var feelsLike = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clear
        
        sunsetLabel.text = "Sunrise:  \(sunsetTime)"
        sunriseLabel.text = "Sunset: \(sunriseTime)"
        dailySumLabel.text = dailySummary
        humidtyLabel.text = "Humidity: \(Int(round(humidity * 100)))%"
        windSpeedLabel.text = "Wind Speed: \(windSpeed) mph"
        chanceOfRainLabel.text = "Chance of Rain: \(Int(round(chanceOfRain)))%"
        feelsLikeLabel.text = "Feels Like: \(feelsLike)°"
        
        let recognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(DetailVC.swipeRight(recognizer:)))
        recognizer.direction = .right
        self.view .addGestureRecognizer(recognizer)
   
    }
    
    
    func swipeRight(recognizer : UISwipeGestureRecognizer) {

        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return weekday.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! WeekdayTableViewCell
        
        let minAndMaxTemp = "\(Int(round((minTemp)[indexPath.row])))°/\(Int(round((maxTemp)[indexPath.row])))°"
        cell.weekdayLabel.text = weekday[indexPath.row]
        cell.tempLabel.text = minAndMaxTemp
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.backgroundColor = UIColor.clear

    }

}

