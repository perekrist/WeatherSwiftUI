//
//  ContentView.swift
//  Weather
//
//  Created by Перегудова Кристина on 12.02.2020.
//  Copyright © 2020 perekrist. All rights reserved.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct ContentView: View {
    
    @ObservedObject var weatherObserver = WeatherObserver()
    
    var cities = ["Tomsk", "Texas", "Moscow", "London", "Paris"]
    @State private var selectedCity = 0
    
    var body: some View {
        ZStack {
            if (weatherObserver.weatherModel != nil) {
                Color
                    .init(weatherObserver.weatherModel!.isDay ? UIColor.day : UIColor.night)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Picker("Label", selection: $selectedCity) {
                        ForEach(0 ..< cities.count) { index in
                            Text(self.cities[index])
                                .tag(index)
                                .foregroundColor(.orange)
                        }
                    }
                    .pickerStyle(WheelPickerStyle()).labelsHidden()
                    Button(action: {
                        self.weatherObserver.request(city: self.cities[self.selectedCity])
                    }) {
                        Text("Submit")
                            .fontWeight(.medium)
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(30)
                            .foregroundColor(.white)
                    }
                    Text(String(weatherObserver.weatherModel!.query))
                        .font(.title)
                        .fontWeight(.light)
                        .padding()
                        .multilineTextAlignment(.center)
                        .foregroundColor(weatherObserver.weatherModel!.isDay ? Color.black : Color.white)
                    
                    Text(String(weatherObserver.weatherModel!.date))
                        .font(.system(size: 22))
                        .foregroundColor(weatherObserver.weatherModel!.isDay ? Color.black : Color.white)
                    
                    AnimatedImage(url: URL(string: weatherObserver.weatherModel!.icon)).resizable()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .shadow(radius: 20)
                    Spacer()
                    Text(String(weatherObserver.weatherModel!.weatherDescription))
                        .font(.system(size: 20))
                        .foregroundColor(weatherObserver.weatherModel!.isDay ? Color.black : Color.white)
                    Text(String(weatherObserver.weatherModel!.temp) + " °C")
                        .font(.system(size: 50))
                        .fontWeight(.heavy)
                        .foregroundColor(weatherObserver.weatherModel!.isDay ? Color.black : Color.white)
                    
                    Spacer()
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            CardView(title: "WIND SPEED", count: weatherObserver.weatherModel!.windSpeed, addition: "m/s", isDay: self.weatherObserver.weatherModel!.isDay)
                            CardView(title: "HUMIDITY", count: weatherObserver.weatherModel!.humidity, addition: "%", isDay: self.weatherObserver.weatherModel!.isDay)
                            CardView(title: "FEELS LIKE", count: weatherObserver.weatherModel!.feelsLike, addition: "°C", isDay: self.weatherObserver.weatherModel!.isDay)
                            CardView(title: "PRESSURE", count: weatherObserver.weatherModel!.pressure, addition: "", isDay: self.weatherObserver.weatherModel!.isDay)
                        }
                    }
                }
            }
            
            if self.weatherObserver.isLoading {
                LoaderView()
            }
        }.onAppear {
            self.weatherObserver.request(city: self.cities[self.selectedCity])
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
