//
//  WeatherData.swift
//  YahooWeather
//
//  Created by Denis Andreev on 29/10/2016.
//  Copyright © 2016 Denis Andreev. All rights reserved.
//

import Foundation

class WeatherData {
    
    private var data: [String: Any]?
    private var forecast: [[String: Any]]?
    private var condition: [String: Any]?
    private var items: [String: Any]?
    private var astronomy: [String: Any]?
    private var wind: [String: Any]?
    private var channel: [String: Any]?
    
    init(weatherDict: Dictionary<String, Any>) {
        data = weatherDict
        parseChannel()
        parseForecast()
    }
    
    private func parseChannel(){
        if data != nil {
            guard let query = data!["query"] as? [String: Any],
                let result = query["results"] as? [String: Any], let channel = result["channel"] as? [String: Any] else {
                    return;
            }
            self.channel = channel
        }
    }
    
    private func parseItem(){
        if data != nil {
            guard let item = self.channel!["item"] as? [String: Any] else {
                    return;
            }
            self.items = item
        }

    }
    
    private func parseForecast() {
        if items == nil {
            parseItem()
        }
        if data != nil {
            guard let fcast = items!["forecast"] as? [[String: Any]] else {
                    return;
            }
            self.forecast = fcast
        }
    }
    
    private func parseCondition() {
        if items == nil {
            parseItem()
        }
        if data != nil {
            guard let condition = items!["condition"] as? [String: Any] else {
                return;
            }
            self.condition = condition
        }
    }
    
    private func parseWind() {
        if items == nil {
            parseChannel()
        }
        if data != nil {
            guard let wind = channel!["wind"] as? [String: Any] else {
                return;
            }
            self.wind = wind
        }

    }
    
    private func parseAstro() {
        if items == nil {
            parseChannel()
        }
        if data != nil {
            guard let astro = channel!["astronomy"] as? [String: Any] else {
                return;
            }
            self.astronomy = astro
        }
    }
    
    public func getCondition() -> [String: Any] {
        if condition == nil {
            parseCondition()
        }
        return self.condition!
    }
    public func getForecast() -> [[String: Any]] {
        if forecast == nil {
            parseForecast()
        }
        return self.forecast!
    }
    
    public func getWind() -> [String: Any] {
        if wind == nil {
            parseWind()
        }
        return self.wind!
    }
    public func getAstronomy() -> [String: Any] {
        if astronomy == nil {
            parseAstro()
        }
        return self.astronomy!
    }
}
