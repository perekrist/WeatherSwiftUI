//
//  ContentView.swift
//  Weather
//
//  Created by Перегудова Кристина on 12.02.2020.
//  Copyright © 2020 perekrist. All rights reserved.
//

import SwiftUI
import Alamofire
import SwiftyJSON
import SDWebImage

struct ContentView: View {
    
    @ObservedObject var obs = observer()
    
    var body: some View {
        NavigationView {
            VStack {
                
                Text(String(obs.temp)).bold().fontWeight(.heavy)
                Text(String(obs.weatherDescription))
                Spacer()
                Text("Wind speed: " + String(obs.windSpeed))
                Text("Humidity: " + String(obs.humidity))
                Text("Fells like: " + String(obs.feelsLike))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class observer: ObservableObject {
    
    @Published var temp = 0
    @Published var windSpeed = 0
    @Published var humidity = 0
    @Published var iconUrl = ""
    @Published var weatherDescription = ""
    @Published var feelsLike = 0
    
    @Published var img = UIImage()
    
    init() {
        Alamofire.request("http://api.weatherstack.com/current?access_key=6da4cdcc62d4d30bdd4a317b7dea6ecf&query=Tomsk").responseData { (data) in
            let json = try! JSON(data: data.data!)
            let current = json["current"]
            
            self.temp = current["temperature"].intValue
            self.windSpeed = current["wind_speed"].intValue
            self.humidity = current["humidity"].intValue
            self.iconUrl = current["weather_icons"][0].stringValue
            self.weatherDescription = current["weather_descriptions"][0].stringValue
            self.feelsLike = current["feelslike"].intValue
            
            
        }
        
        
    }
}
