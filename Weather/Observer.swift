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
    var iconUrl = ""
    @Published var url = URL(string: "")
    @Published var weatherDescription = "Description"
    @Published var feelsLike = 11
    @Published var isDay = false
    @Published var pressure = 1000
    
    @Published var img = UIImage()
    
    func request(city: String) {
        let url = baseUrl + city
        
        Alamofire.request(url).responseData { (data) in
            
            let json = try! JSON(data: data.data!)
            if json["success"].stringValue != "false" {
                self.query = json["request"]["query"].stringValue
                
                let current = json["current"]
                
                self.temp = current["temperature"].intValue
                self.windSpeed = current["wind_speed"].intValue
                self.humidity = current["humidity"].intValue
                self.iconUrl = current["weather_icons"][0].stringValue
                self.weatherDescription = current["weather_descriptions"][0].stringValue
                self.feelsLike = current["feelslike"].intValue
                self.url = URL(string: self.iconUrl)
                self.pressure = current["pressure"].intValue
                if current["is_day"] == "yes" {
                   self.isDay = true
                } else { self.isDay = false }
            }
        }
    }
}

