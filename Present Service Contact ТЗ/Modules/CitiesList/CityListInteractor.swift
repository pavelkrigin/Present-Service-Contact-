//
//  CityListInteractor.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import Foundation

// MARK: - Protocol
protocol CitiesListInteractorInput {
    func fetchWeather(for city: String)
}

protocol CitiesListInteractorOutput: AnyObject {
    func didFetchWeather(city: City)
    func didFailFetchingWeather(with error: Error)
}

// MARK: - Class
final class CitiesListInteractor: CitiesListInteractorInput {
    weak var presenter: CitiesListInteractorOutput?
    private let weatherAPI = WeatherAPI()

    func fetchWeatherForCities(_ cities: [String]) {
        var cityWeatherData: [String: Double] = [:]

        let group = DispatchGroup()

        for city in cities {
            group.enter()
            weatherAPI.fetchCurrentWeather(for: city) { result in
                switch result {
                case .success(let weather):
                    cityWeatherData[city] = weather.main.temp
                case .failure(let error):
                    print("Failed to fetch weather for \(city): \(error)")
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            self.presenter?.didFetchWeatherData(cityWeatherData)
        }
    }
}

//// MARK: - Structure
//struct WeatherResponse: Decodable {
//    let name: String
//    let main: MainWeather
//}
//
//struct MainWeather: Decodable {
//    let temp: Double
//}
