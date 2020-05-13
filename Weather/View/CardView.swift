//
//  CardView.swift
//  Weather
//
//  Created by Перегудова Кристина on 13.02.2020.
//  Copyright © 2020 perekrist. All rights reserved.
//

import SwiftUI

struct CardView: View {
    
    var title = ""
    var count = 0
    var addition = ""
    var isDay = true
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(
                    gradient: .init(colors: isDay ? [Color.red, Color.orange] : [Color.blue, Color.green]),
                    startPoint: .top,
                    endPoint: .bottom
                ))
                .frame(width: 140, height: 120)
                .cornerRadius(30)
                .padding(10)
                .shadow(radius: 7)
            if !isDay {
                Rectangle()
                    .fill(Color.black.opacity(0.1))
                    .frame(width: 140, height: 120)
                    .cornerRadius(30)
                    .padding(10)
            }
            
            VStack {
                Text(title)
                    .foregroundColor(.white)
                    .font(.system(size: 17))
                    .bold()
                HStack {
                    Text("\(count)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                    Text(addition)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                }
            }
        }
    }
}
