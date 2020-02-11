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
            List(obs.datas) { i in
                card(name: i.name, url: i.url)
            }.navigationBarTitle("JSON PArsing")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class observer: ObservableObject {
    
    @Published var datas = [datatype]()
    
    init() {
        Alamofire.request("https://api.github.com/users/hadley/orgs").responseData { (data) in
            
            let json = try! JSON(data: data.data!)
            for i in json {
                self.datas.append(datatype(
                    id: i.1["id"].intValue,
                    name: i.1["login"].stringValue,
                    url: i.1["avater_url"].stringValue))
            }
        }
    }
}

struct datatype: Identifiable {
    
    var id: Int
    var name: String
    var url: String
}

struct card: View {
    
    var name = ""
    var url = ""
    
    var body: some View {
        
        HStack {
            Text("img")
            Text(name).fontWeight(.heavy)
        }
    }
}
