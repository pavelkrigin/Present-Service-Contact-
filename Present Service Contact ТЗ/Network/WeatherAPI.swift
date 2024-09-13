//
//  WeatherAPI.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 13.09.2024.
//"36b641236ecb3f0a4d7aec5e32ee2e21"

import Foundation

final class WeatherAPI {
    private let apiKey = "36b641236ecb3f0a4d7aec5e32ee2e21" 
    private let baseURL = "https://api.openweathermap.org/data/2.5/"
    
    enum WeatherAPIError: Error {
        case invalidURL
        case requestFailed
        case invalidResponse
        case decodingError
    }

    func fetchCurrentWeather(for city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let urlString = "\(baseURL)weather?q=\(city)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            completion(.failure(WeatherAPIError.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(WeatherAPIError.invalidResponse))
                return
            }

            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(weatherResponse))
            } catch {
                completion(.failure(WeatherAPIError.decodingError))
            }
        }
        task.resume()
    }

    func fetchWeatherForecast(for city: String, days: Int, completion: @escaping (Result<WeatherForecastResponse, Error>) -> Void) {
        let urlString = "\(baseURL)forecast/daily?q=\(city)&cnt=\(days)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            completion(.failure(WeatherAPIError.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(WeatherAPIError.invalidResponse))
                return
            }

            do {
                let forecastResponse = try JSONDecoder().decode(WeatherForecastResponse.self, from: data)
                completion(.success(forecastResponse))
            } catch {
                completion(.failure(WeatherAPIError.decodingError))
            }
        }
        task.resume()
    }
}
