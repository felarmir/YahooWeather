//
//  APIYahoo.swift
//  YahooWeather
//
//  Created by Denis Andreev on 26/10/2016.
//  Copyright © 2016 Denis Andreev. All rights reserved.
//

import Foundation


let QUERY_PREFIX = "https://query.yahooapis.com/v1/public/yql?q="
let QUERY_SUFFIX = "&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
//
func queryToYahoo(statement: String) -> Dictionary<String, AnyObject> {
    let query = "\(QUERY_PREFIX)\(statement.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)\(QUERY_SUFFIX)"
    print(query)
    var dictionary: Dictionary<String, AnyObject>?
    do {
        let data: Data = try Data(contentsOf: URL(string:query)!) as Data
        dictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)  as? Dictionary<String, AnyObject>
    } catch {
        print("Error loading data...")
    }
    return dictionary!
}

