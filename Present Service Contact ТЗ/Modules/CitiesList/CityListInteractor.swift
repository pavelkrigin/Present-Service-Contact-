//
//  CityListInteractor.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import Foundation

// MARK: - CitiesListInteractorInput
protocol CitiesListInteractorInput: AnyObject {
    func fetchWeatherForCities(_ cities: [String])
}

// MARK: - CitiesListInteractorOutput
protocol CitiesListInteractorOutput: AnyObject {
    func didFetchWeatherData(_ data: [String: Double])
    func didFailFetchingWeatherData(with error: Error)
}

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
        
        group.notify(queue: .main) { [weak self] in
            self?.presenter?.didFetchWeatherData(cityWeatherData)
        }
    }
}
