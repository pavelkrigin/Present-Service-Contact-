//
//  WeatherService.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import Foundation

enum WeatherError: Error {
    case cityNotFound
    case networkError
    case unknownError
}

class WeatherService {
    let apiKey = "36b641236ecb3f0a4d7aec5e32ee2e21"
    
    func fetchWeatherForecast(for city: String, completion: @escaping (Result<ForecastData, WeatherError>) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.unknownError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                completion(.failure(.networkError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.unknownError))
                return
            }
            
            do {
                let forecastData = try JSONDecoder().decode(ForecastData.self, from: data)
                completion(.success(forecastData))
            } catch {
                completion(.failure(.unknownError))
            }
        }.resume()
    }
}
