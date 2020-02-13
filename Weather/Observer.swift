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

class Observer: ObservableObject {
    @Published var baseUrl = "http://api.weatherstack.com/current?access_key=6da4cdcc62d4d30bdd4a317b7dea6ecf&query="
    
    @Published var query = "City, Country"
    @Published var temp = 10
    @Published var windSpeed = 10
    @Published var humidity = 10
    @Published var icon = "https://assets.weatherstack.com/images/wsymbols01_png_64/wsymbol_0001_sunny.png"
    @Published var weatherDescription = "Description"
    @Published var feelsLike = 11
    @Published var isDay = Color(red: 255 / 255, green: 250 / 255, blue: 200 / 255)
    @Published var textColor = Color.black
    @Published var pressure = 1000
    @Published var date = "2020"
    
    @Published var img = UIImage()
    
    func request(city: String) {
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
                    self.isDay = Color(red: 255 / 255, green: 250 / 255, blue: 200 / 255)
                    self.textColor = Color.black
                } else {
                    self.isDay = Color(red: 0 / 255, green: 0 / 255, blue: 50 / 255)
                    self.textColor = Color.white
                }
            }
        }
    }
}

