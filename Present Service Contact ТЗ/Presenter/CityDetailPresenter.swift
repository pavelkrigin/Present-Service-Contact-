//
//  CityDetailPresenter.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import Foundation

protocol CityDetailPresenterProtocol: AnyObject {
    func viewDidLoad()
}

class CityDetailPresenter: CityDetailPresenterProtocol {
    weak var view: CityDetailViewProtocol?
    var interactor: CityDetailInteractorProtocol?
    var cityName: String
    
    init(cityName: String) {
        self.cityName = cityName
    }
    
    func viewDidLoad() {
        interactor?.fetchWeather(for: cityName)
    }
}

extension CityDetailPresenter: CityDetailInteractorOutputProtocol {
    func didFetchWeather(_ weather: WeatherData) {
        view?.showWeatherDetails(weather)
    }
    
    func fetchWeatherForecast(for city: String, days: Int) {
        weatherService.fetchWeatherForecast(for: city) { result in
            switch result {
            case .success(let forecast):
                // Обработка прогноза погоды на несколько дней
                self.presenter?.didFetchWeatherForecast(forecast)
            case .failure(let error):
                print("Failed to fetch weather forecast: \(error)")
            }
        }
    }
}
