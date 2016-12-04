//
//  YahooWeatherTests.swift
//  YahooWeatherTests
//
//  Created by Denis Andreev on 24/10/2016.
//  Copyright © 2016 Denis Andreev. All rights reserved.
//

import XCTest
@testable import YahooWeather

class YahooWeatherTests: XCTestCase {
    
    var vc: MainView!
    
    override func setUp() {
        super.setUp()
        let storyb = UIStoryboard(name: "Main", bundle: Bundle.main)
        vc = storyb.instantiateInitialViewController() as! MainView
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCalculateCelsius() {
        vc.isCelsius = true
        let v = vc.converter(temp: 10)
        XCTAssert(v == -12)
    }
    
    func testCalculateFaringate() {
        vc.isCelsius = false
        let v = vc.converter(temp: 10)
        XCTAssertTrue(v == 10)
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
