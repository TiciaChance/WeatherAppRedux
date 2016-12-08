//
//  WeekdayTableViewCell.swift
//  WeatherAppRedux
//
//  Created by Laticia Chance on 12/8/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import UIKit

class WeekdayTableViewCell: UITableViewCell {
    
    var weather = WeatherAPI()

    @IBOutlet weak var weekdayLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
