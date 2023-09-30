import Foundation

struct WeatherData: Codable {
    let data: TimelineData
}

struct TimelineData: Codable {
    let Timelines: [Timeline]
}

struct Timeline: Codable {
    let intervals: [Interval]
}

struct Interval: Codable {
    let StartTime: String
    let value: Values
}

struct Values: Codable {
    let temperature: Double
    let humidity: Double
    let windSpeed: Double
    let weathercode: String
    let weatherCodeNight: String
    let weatherCodeDay: String
}

class WeatherServices {
    static let APIKEY = "JMFLiTLohyQyZa911BKWBf4Rb9qCuK56"
    static let baseURL = "https://api.tomorrow.io/v4/timelines"

    static func fetchWeatherData(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherData, Error>) -> Void) {

        let urlstring = "\(baseURL)?Location=\(latitude),\(longitude)&fields=temprature,humidity,windSpeed,weatherCode,WeatherCodeNight,weatherCodeDay&apikey=\(APIKEY)"

        if let url = URL(string: urlstring) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let weatherData = try decoder.decode(WeatherData.self, from: data)
                        completion(.success(weatherData))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }.resume()
        }
    }
}
