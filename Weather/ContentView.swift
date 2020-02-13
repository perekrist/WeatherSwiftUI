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
    
    @ObservedObject var obs = Observer()
    
    var cities = ["Tomsk", "Texas", "Moscow", "London", "Paris"]
    @State private var selectedCity = 0
        
    var body: some View {
        ZStack {
            obs.isDay.edgesIgnoringSafeArea(.all)
            
            VStack {
                Picker("Label", selection: $selectedCity) {
                    ForEach(0 ..< cities.count) { index in
                        Text(self.cities[index])
                            .tag(index)
                            .foregroundColor(self.obs.textColor)
                    }
                }
                    .pickerStyle(WheelPickerStyle()).labelsHidden()
                    .onAppear {
                        self.obs.request(city: self.cities[self.selectedCity])
                    }
                Button(action: {
                    self.obs.request(city: self.cities[self.selectedCity])
                }) {
                    Text("Submit")
                        .fontWeight(.medium)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(30)
                        .foregroundColor(.white)
                }
                Text(String(obs.query))
                    .font(.title)
                    .fontWeight(.light)
                    .padding()
                    .multilineTextAlignment(.center)
                    .foregroundColor(self.obs.textColor)
                Text(String(obs.date))
                    .font(.system(size: 22))
                    .foregroundColor(self.obs.textColor)
                AnimatedImage(url: URL(string: obs.icon)).resizable()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .shadow(radius: 20)
                Spacer()
                Text(String(obs.weatherDescription))
                    .font(.system(size: 20))
                    .foregroundColor(self.obs.textColor)
                Text(String(obs.temp) + " °C")
                    .font(.system(size: 50))
                    .fontWeight(.heavy)
                    .foregroundColor(self.obs.textColor)
                Spacer()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        CardView(title: "WIND SPEED", count: obs.windSpeed, addition: "m/s")
                        CardView(title: "HUMIDITY", count: obs.humidity, addition: "%")
                        CardView(title: "FEELS LIKE", count: obs.feelsLike, addition: "°C")
                        CardView(title: "PRESSURE", count: obs.pressure, addition: "")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
