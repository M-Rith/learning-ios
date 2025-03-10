//
//  ContentView.swift
//  WeatherApp
//
//  Created by AppleD0g on 3/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var city: String = ""
    @State private var isFetchingWeather : Bool = false
    @State private var weather: Weather?
    
    let geocodingClient = GeocodingClient()
    let weatherClient = WeatherClient()
    
//    private func fetchWeather() async {
//        let location geocodingClient.coordinateByCity(city)
//        weatherClient.fetchWeather(location: location)
//    }
    
    private func fetchWeather() async {
        do {
            guard let location = try await geocodingClient.coordinateByCity(city) else {return}
            weather = try await  weatherClient.fetchWeather(location: location)
        }catch {
            print(error)
        }
    }
    
    
    var body: some View {
        
        VStack {
            TextField("City", text: $city).textFieldStyle(.roundedBorder).onSubmit {
                isFetchingWeather = true
            }.task(id: isFetchingWeather) {
                if isFetchingWeather {
                    await fetchWeather()
                    isFetchingWeather = false
                    city = ""
                    
                }
            }
            Spacer()
            
            if let weather {
                Text(MeasurementFormatter.temperature(value: weather.temp)).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            }
            
            Spacer()
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
