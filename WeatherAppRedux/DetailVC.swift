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
    
    var sunriseTime = String()
  
    var sunsetTime = String()
    var humidity = Double()
    var windSpeed = Double()
    var weekday = [String]()
    var minTemp = [Double]()
    var maxTemp = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clear
        
        sunsetLabel.text = "Sunrise: \(sunsetTime)"
        sunriseLabel.text = "Sunset: \(sunriseTime)"

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return weekday.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! WeekdayTableViewCell
        
        let minAndMaxTemp = "\(Int(round((minTemp)[indexPath.row])))/\(Int(round((maxTemp)[indexPath.row])))"
        cell.weekdayLabel.text = weekday[indexPath.row]
        cell.tempLabel.text = minAndMaxTemp
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.backgroundColor = UIColor.clear

    }

}

