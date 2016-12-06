//
//  WeatherDesc.swift
//  YahooWeather
//
//  Created by Denis Andreev on 01/11/2016.
//  Copyright © 2016 Denis Andreev. All rights reserved.
//

import UIKit

class WeatherDetailCell: UITableViewCell {

    var sunrise: UILabel = {
        let sunrise = UILabel()
        sunrise.translatesAutoresizingMaskIntoConstraints = false
        sunrise.textColor = .white
        return sunrise
    }()
    
    var sunset: UILabel = {
        let sunset = UILabel()
        sunset.translatesAutoresizingMaskIntoConstraints = false
        sunset.textColor = .white
        return sunset
    }()
    
    var wind: UILabel = {
        let wind = UILabel()
        wind.translatesAutoresizingMaskIntoConstraints = false
        wind.textColor = .white
        return wind
    }()
    
    var sunsetTitle: UILabel = {
        let sunsetTitle = UILabel()
        sunsetTitle.textAlignment = .right
        sunsetTitle.translatesAutoresizingMaskIntoConstraints = false
        sunsetTitle.textColor = .white
        sunsetTitle.text = "Sunset:"
        return sunsetTitle
    }()
    
    
    var sunriseTitle: UILabel = {
        let sunriseTitle = UILabel()
        sunriseTitle.textAlignment = .right
        sunriseTitle.translatesAutoresizingMaskIntoConstraints = false
        sunriseTitle.textColor = .white
        sunriseTitle.text = "Sunrise:"
        return sunriseTitle
    }()
    
    
    var windTitle: UILabel = {
        let windTitle = UILabel()
        windTitle.textAlignment = .right
        windTitle.translatesAutoresizingMaskIntoConstraints = false
        windTitle.textColor = .white
        windTitle.text = "Wind:"
        return windTitle
    }()

    
    
    func setUP() {
        
        addSubview(sunriseTitle)
        addSubview(sunsetTitle)
        addSubview(windTitle)
        addSubview(sunrise)
        addSubview(sunset)
        addSubview(wind)
        
        let position1 = ((UIApplication.shared.keyWindow?.bounds.width)!/2) - 110
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(\(position1))-[srt(100)]-5-[sr]-(>=20)-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["sr":sunrise, "srt":sunriseTitle]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(\(position1))-[sst(100)]-5-[ss]-(>=20)-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["ss":sunset, "sst":sunsetTitle]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(\(position1))-[wdt(100)]-5-[wd]-(>=20)-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["wd":wind, "wdt":windTitle]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[sr]-5-[ss]-5-[wd]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["sr":sunrise, "ss":sunset, "wd":wind]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[srt]-5-[sst]-5-[wdt]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["srt":sunriseTitle, "sst":sunsetTitle, "wdt":windTitle]))
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 5, width: self.bounds.width, height: 1)
        topBorder.backgroundColor = UIColor.white.cgColor
        self.layer.addSublayer(topBorder)
        
        backgroundColor = .clear
        selectionStyle = .none
        setUP()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
