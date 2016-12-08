//
//  DetailVC.swift
//  WeatherAppRedux
//
//  Created by Laticia Chance on 12/6/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    
    @IBOutlet weak var sunriseLabel: UILabel!
    
    @IBOutlet weak var sunsetLabel: UILabel!
    
    var sunriseTime = String()
    var sunsetTime = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sunsetLabel.text = sunsetTime
        sunriseLabel.text = sunriseTime

        // Do any additional setup after loading the view.
    }

}

