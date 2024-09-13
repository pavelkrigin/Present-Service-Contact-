//
//  CityDetailInteractor.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import Foundation

// MARK: - Protocol
protocol CityDetailInteractorInput {
    func fetchWeatherDetail(for city: String, days: Int)
}

protocol CityDetailInteractorOutput: AnyObject {
    func didFetchWeatherDetail(_ details: [WeatherDetail])
    func didFailFetchingWeatherDetail(with error: Error)
}

// MARK: - Class
final class CityDetailInteractor: CityDetailInteractorInput {
    weak var presenter: CityDetailInteractorOutput?
    private let weatherAPI = WeatherAPI()
    
    func fetchWeatherDetail(for city: String, days: Int) {
        weatherAPI.fetchWeatherForecast(for: city, days: days) { [weak self] result in
            switch result {
            case .success(let forecast):
                let weatherDetails = forecast.list.map { day in
                    WeatherDetail(
                        date: DateFormatter.localizedString(from: Date(timeIntervalSince1970: TimeInterval(day.dt)), dateStyle: .medium, timeStyle: .none),
                        temperature: day.temp.day,
                        description: day.weather.first?.description ?? "No data"
                    )
                }
                self?.presenter?.didFetchWeatherDetail(weatherDetails)
            case .failure(let error):
                self?.presenter?.didFailFetchingWeatherDetail(with: error)
            }
        }
    }
}

//MARK: - Structure
struct ForecastResponse: Decodable {
    let list: [ForecastDay]
    
    struct ForecastDay: Decodable {
        let dt: String
        let temp: Temperature
        let weather: [WeatherDescription]
    }
    
    struct Temperature: Decodable {
        let day: Double
    }
    
    struct WeatherDescription: Decodable {
        let description: String
    }
}
