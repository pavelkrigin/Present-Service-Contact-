//
//  WeatherService.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import Foundation

struct WeatherService {
    private let apiKey = "your_api_key_here" // Укажи свой API ключ
    private let baseUrl = "https://api.openweathermap.org/data/2.5"
    
    func fetchWeather(for city: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let urlString = "\(baseUrl)/weather?q=\(city)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            
            do {
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                completion(.success(weatherData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchForecast(for city: String, days: Int, completion: @escaping (Result<ForecastData, Error>) -> Void) {
        let urlString = "\(baseUrl)/forecast/daily?q=\(city)&cnt=\(days)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            
            do {
                let forecastData = try JSONDecoder().decode(ForecastData.self, from: data)
                completion(.success(forecastData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
