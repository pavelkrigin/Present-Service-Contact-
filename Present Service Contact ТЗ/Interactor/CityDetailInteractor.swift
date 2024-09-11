//
//  CityDetailInteractor.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import Foundation

protocol CityDetailInteractorProtocol: AnyObject {
    func fetchWeather(for city: String)
}

protocol CityDetailInteractorOutputProtocol: AnyObject {
    func didFetchWeather(_ weather: WeatherData)
}

class CityDetailInteractor: CityDetailInteractorProtocol {
    weak var presenter: CityDetailInteractorOutputProtocol?
    let weatherService = WeatherService()
    
    func fetchWeather(for city: String) {
        weatherService.fetchWeatherForecast(for: city) { result in
            switch result {
            case .success(let data):
                self.presenter?.didFetchWeather(WeatherData(name: <#T##String#>, main: <#T##Main#>, weather: <#T##[Weather]#>))
            case .failure(let error):
                print("Failed to fetch weather: \(error)")
            }
        }
    }
}
