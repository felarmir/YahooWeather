//
//  WeatherDesc.swift
//  YahooWeather
//
//  Created by Denis Andreev on 01/11/2016.
//  Copyright © 2016 Denis Andreev. All rights reserved.
//

import UIKit

class WeatherDetailCell: UITableViewCell {

    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var wind: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
