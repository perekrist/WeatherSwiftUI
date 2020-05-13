//
//  Observer.swift
//  Weather
//
//  Created by Перегудова Кристина on 12.02.2020.
//  Copyright © 2020 perekrist. All rights reserved.
//

import SwiftUI
import Alamofire
import SwiftyJSON
import SDWebImageSwiftUI

class WeatherObserver: ObservableObject {
    
    var baseUrl = "http://api.weatherstack.com/current?access_key=6da4cdcc62d4d30bdd4a317b7dea6ecf&query="
    
    private var query = ""
    private var temp = 0
    private var windSpeed = 0
    private var humidity = 0
    private var icon = ""
    private var weatherDescription = ""
    private var feelsLike = 0
    private var isDay = true
    private var pressure = 0
    private var date = ""
    
    @Published var weatherModel: WeatherModel?
    @Published var isLoading = false
        
    func request(city: String) {
        
        isLoading = true
        
        let url = baseUrl + city
        
        Alamofire.request(url).responseData { (data) in
            
            let json = try! JSON(data: data.data!)
            
            if json["success"].stringValue != "false" {
                self.query = json["request"]["query"].stringValue
                
                let current = json["current"]
                
                self.temp = current["temperature"].intValue
                self.weatherDescription = current["weather_descriptions"][0].stringValue
                self.date = json["location"]["localtime"].stringValue
                
                self.windSpeed = current["wind_speed"].intValue
                self.humidity = current["humidity"].intValue
                self.feelsLike = current["feelslike"].intValue
                self.pressure = current["pressure"].intValue
                
                self.icon = current["weather_icons"][0].stringValue
                
                if current["is_day"] == "yes" {
                    self.isDay = true
                } else {
                    self.isDay = false
                }
                
                self.weatherModel = WeatherModel(query: self.query, temp: self.temp, windSpeed: self.windSpeed, humidity: self.humidity, icon: self.icon, weatherDescription: self.weatherDescription, feelsLike: self.feelsLike, isDay: self.isDay, pressure: self.pressure, date: self.date)
                
                self.isLoading = false
                
            }
            
        }
    }
}

