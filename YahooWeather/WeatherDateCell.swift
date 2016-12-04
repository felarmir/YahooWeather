//
//  WeatherDateCell.swift
//  YahooWeather
//
//  Created by Denis Andreev on 31/10/2016.
//  Copyright © 2016 Denis Andreev. All rights reserved.
//

import UIKit

class WeatherDateCell: UITableViewCell {

    let weakDay: UILabel = {
        let weakDay = UILabel()
        weakDay.translatesAutoresizingMaskIntoConstraints = false
        weakDay.textColor = .white
        return weakDay
    }()
    var high: UILabel = {
        let high = UILabel()
        high.textColor = .white
        high.translatesAutoresizingMaskIntoConstraints = false
        return high
    }()
    var low: UILabel = {
        let low = UILabel()
        low.textColor = .white
        low.translatesAutoresizingMaskIntoConstraints = false
        return low
    }()
    
    var weatherImage: UIImageView = {
        let weatherImage = UIImageView()
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        return weatherImage
    }()
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = .clear
        }
    }
    
    func setUp() {
        addSubview(weakDay)
        addSubview(high)
        addSubview(low)
        addSubview(weatherImage)
        
        let ch: CGFloat = self.bounds.height - 4
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[day(100)]-[img(\(ch))]-(>=20)-[high(35)]-10-[low(35)]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["day": weakDay, "img":weatherImage, "high":high, "low":low]))

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[day]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["day": weakDay]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[img(\(ch))]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["img": weatherImage]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[low]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["low": low]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[high]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["high": high]))
        
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
