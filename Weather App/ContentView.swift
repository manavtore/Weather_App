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
            
            VStack (spacing:8){
                Text("Delhi, UP")
                    .font(.system(size: 32, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .padding()
               
              
                VStack(spacing:8){
                    Image(systemName: "cloud.sun.fill")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:200,height: 200)
                 
                    Text("76°")
                        .font(.system(size: 84))
                            .foregroundColor(.white)
                        
                    
                  
                }
//                HStack{
//                    WeatherOfEachDay(
//                    dayoftheweeek: "Tue", weathercondition: "cloud.sun.rain.fill", Temparature: 74
//                    )
//                    WeatherOfEachDay(
//                    dayoftheweeek: "Wed", weathercondition: "sun.max.fill", Temparature: 76
//                    )
//                    WeatherOfEachDay(
//                    dayoftheweeek: "Thu", weathercondition: "cloud.moon.rain.fill", Temparature: 79
//                    )
//                    WeatherOfEachDay(
//                    dayoftheweeek: "Fri", weathercondition: "cloud.rain.fill", Temparature: 76
//                    )
//                    WeatherOfEachDay(
//                    dayoftheweeek: "Sat", weathercondition: "wind", Temparature: 76
//                    )
//                    
//                }.padding(.bottom,40)
//                Button{
//                    print("click me to enter")
//                }label: {
//                    Text("Change Day Time")
//                }.frame(width:200,height: 50)
//                    .background(Color.white)
//                    .font(.system(size: 20,weight: .medium,design: .default))
//                    .cornerRadius(10)
             
                Text("\(Int(weatherData.data.Timelines[0].intervals.value.temperature))°")
                    .font(.system(size:84))
                    .foregroundColor(.white)
                
                HStack{
                    ForEach(weatherData?.data.Timelines[0].intervals.prefix(5).id,:\.self.StartTime){ interval in
                        WeatherOfEachDay(dayoftheweeek: "Day", weathercondition: "Sun.max.fill", Temparature: Int(interval.value.temperature)
                        )
                    }
                }
                Spacer()
        
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
