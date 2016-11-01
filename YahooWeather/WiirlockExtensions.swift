//
//  WiirlockExtensions.swift
//  YahooWeather
//
//  Created by Denis Andreev on 26/10/2016.
//  Copyright © 2016 Denis Andreev. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func makeBloorImage(targetImageView:UIImageView) {
        let bloor = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let bloorView = UIVisualEffectView(effect: bloor)
        bloorView.alpha = 0.5
        bloorView.frame = targetImageView.bounds
        
        bloorView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        targetImageView.addSubview(bloorView)
    }
}
