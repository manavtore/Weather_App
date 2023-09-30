//
//  ContentView.swift
//  Weather App
//
//  Created by Manav Tore on 19/09/23.
//

import SwiftUI

struct ContentView: View {
    @State private var weatherData: WeatherData?
    
    var body: some View {
        ZStack() {
            LinearGradient(colors: [.blue, Color(.lightblue) ], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack (spacing: 8) {
                Text("Delhi, UP")
                    .font(.system(size: 32, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .padding()
                
                VStack(spacing: 8) {
                    Image(systemName: "cloud.sun.fill")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                    
                    Text("\(weatherData?.data.Timelines[0].intervals[0].value.temperature ?? 0)°")
                        .font(.system(size: 84))
                        .foregroundColor(.white)
                }
                
                if let weatherData = weatherData {
                    HStack {
                        ForEach(weatherData.data.Timelines[0].intervals.prefix(5), id: \.StartTime) { interval in
                            WeatherOfEachDay(
                                dayoftheweeek: "Day",
                                weathercondition: "Sun.max.fill",
                                Temparature: Int(interval.value.temperature)
                            )
                        }
                    }.padding(.bottom, 40)
                }
                
                Text("\(Int(weatherData?.data.Timelines[0].intervals[0].value.temperature ?? 0))°")
                    .font(.system(size: 84))
                    .foregroundColor(.white)
                
                Spacer()
            }
        }
        .onAppear {
            WeatherServices.fetchWeatherData(latitude: 28.6139, longitude: 77.2090) { result in
                switch result {
                case .success(let weatherData):
                    self.weatherData = weatherData
                case .failure(let error):
                    print("Error fetching weather data: \(error)")
                   
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

struct WeatherOfEachDay: View {
    var dayoftheweeek:String
    var weathercondition:String
    var Temparature:Int
    var body: some View {
        VStack(spacing:10){
            Text(dayoftheweeek).font(.system(size: 35,weight: .medium,design: .default)
            ).foregroundColor(.white)
            Image(systemName: weathercondition)
                .renderingMode(.original)
                .symbolRenderingMode(.multicolor)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 45,height: 45)
            Text("\(Temparature)°").font(.system(size: 35,weight: .medium,design: .default))
                .foregroundColor(.white)
        }
    }
}
