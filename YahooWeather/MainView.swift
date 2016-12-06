//
//  MainView.swift
//  YahooWeather
//
//  Created by Denis Andreev on 24/10/2016.
//  Copyright © 2016 Denis Andreev. All rights reserved.
//

import UIKit
import CoreLocation


class MainView: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var weatherText: UILabel!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var curWeatherPic: UIImageView!
    @IBOutlet weak var currentView: UIView!
    
    let locationManager = CLLocationManager()
    var geocoder = CLGeocoder()
    var placemark = CLPlacemark()
    var weatherDictionary: Dictionary<String, AnyObject>?
    var weatherData: WeatherData?
    var forecast:[[String: Any]]?
    var astro:[String: Any]?
    var wind:[String: Any]?
    var isCelsius: Bool?
    var isCurrentHide: Bool?
    var currentHeight: CGFloat!
    var mouve: CGFloat!
    let cellID = "WEATHERID"
    let descriptCellID = "weatherDeskription"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgImage.image = UIImage(named: monthImage())
        bgImage.makeBloorImage(targetImageView: bgImage)
        tableView.layer.backgroundColor = UIColor.clear.cgColor
        tableView.backgroundColor = UIColor.clear
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 500
        if (UIDevice.current.systemVersion as NSString).floatValue >= 8.0 {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingLocation()
        clearTempText()
        isCelsius = true
        isCurrentHide = false
        currentHeight = currentView.bounds.height
        mouve = 0
        
        tableView.register(WeatherDateCell.self, forCellReuseIdentifier: cellID)
        tableView.register(WeatherDetailCell.self, forCellReuseIdentifier: descriptCellID)
    }

    func monthImage() -> String {
        let day = Date()
        let calendar = Calendar.current
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second
        ]
        let td = calendar.dateComponents(requestedComponents, from: day)
        return ("img/\(td.month!).jpg")
    }
    
    
    func clearTempText() {
        self.cityName.text = ""
        self.currentTemp.text = ""
        self.weatherText.text = ""
    }
    
    
    func loadWeatherData(city: String) {
        weatherDictionary = queryToYahoo(statement: "select * from weather.forecast where woeid in (select woeid from geo.places(1) where text=\"\(city)\")")
        
        weatherData = WeatherData(weatherDict: weatherDictionary!)
        let cond = weatherData?.getCondition()
        forecast = weatherData?.getForecast()
        wind = weatherData?.getWind()
        astro = weatherData?.getAstronomy()
        
        let tText = cond!["temp"] as! String
        currentTemp.text = "\(converter(temp: Int(tText)!))"
        weatherText.text = cond!["text"] as? String
        curWeatherPic.image = UIImage(named: "img/icons/\(cond!["code"] as! String).png")
        
        if forecast != nil {
            tableView.reloadData()
        }
    }

    func converter(temp: Int) -> Int {
        if isCelsius! {
            return (((temp-32) * 5)/9)
        }
        return temp
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations[0]
        
        geocoder.reverseGeocodeLocation(location, completionHandler: {(placemarks, error) in
            let pm = placemarks! as [CLPlacemark]
            if  error == nil && pm.count > 0 {
                var cityName: String?
                if pm[0].locality == nil {
                    cityName = pm[0].name
                } else {
                    cityName = pm[0].locality
                }
                print("Location: \(cityName!)")
                self.cityName.text = cityName!
                self.loadWeatherData(city: cityName!)
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if forecast != nil {
            return 2
        }
        return 0;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if forecast != nil {
                return forecast!.count
            }
        }
        if section == 1 {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var fcell = UITableViewCell()
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! WeatherDateCell
            let forcastItem = forecast![indexPath.row]
            cell.weakDay.text = forcastItem["day"] as? String
            cell.high.text = "\(converter(temp: Int((forcastItem["high"] as? String)!)!))"
            cell.low.text = "\(converter(temp: Int((forcastItem["low"] as? String)!)!))"
            cell.weatherImage.image = UIImage(named: "img/icons/\(forcastItem["code"] as! String).png")
            fcell = cell;
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: descriptCellID, for: indexPath) as! WeatherDetailCell
            cell.sunrise.text = astro!["sunrise"] as? String
            cell.sunset.text = astro!["sunset"] as? String
            cell.wind.text = "\((wind!["speed"] as? String)!) m/s"
            fcell = cell
        }
        return fcell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var rowHeigh = 30
        if indexPath.section == 1 {
            rowHeigh = 75
        }
        return CGFloat(rowHeigh)
    }
   
    @IBAction func swipeGesture(gesture: UIPanGestureRecognizer) {
            let transition = gesture.translation(in: self.view)
                if currentView.layer.position.y < tableView.layer.position.y {
                    tableView.layer.position.y = transition.y
                    currentView.alpha = (transition.y - currentView.layer.position.y) / currentHeight
                }
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller usig segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
