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

class CityDetailInteractor: CityDetailInteractorProtocol {
    var presenter: CityDetailPresenterProtocol?
    let weatherService = WeatherService()
    
    func fetchWeather(for city: String) {
        weatherService.fetchWeather(for: city) { result in
            switch result {
            case .success(let data):
                self.presenter?.didFetchWeather(data)
            case .failure(let error):
                print("Failed to fetch weather: \(error)")
            }
        }
    }
}
