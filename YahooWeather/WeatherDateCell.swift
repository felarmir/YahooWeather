//
//  WeatherDateCell.swift
//  YahooWeather
//
//  Created by Denis Andreev on 31/10/2016.
//  Copyright © 2016 Denis Andreev. All rights reserved.
//

import UIKit

class WeatherDateCell: UITableViewCell {

    @IBOutlet weak var weakDay: UILabel!
    @IBOutlet weak var high: UILabel!
    @IBOutlet weak var low: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
