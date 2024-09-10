//
//  CityListInteractor.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import Foundation

protocol SearchCityInteractorProtocol: AnyObject {
    func searchCity(_ cityName: String)
}

class SearchCityInteractor: SearchCityInteractorProtocol {
    var presenter: SearchCityPresenterProtocol?
    let weatherService = WeatherService()
    
    func searchCity(_ cityName: String) {
        weatherService.fetchWeather(for: cityName) { result in
            switch result {
            case .success(let data):
                let city = City(name: data.name, temperature: data.main.temp)
                self.presenter?.didFetchCity(city)
            case .failure:
                self.presenter?.didFailToFetchCity("City not found")
            }
        }
    }
}
