//
//  CityDetailPresenter.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import Foundation

protocol CityDetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didFetchWeather(_ weather: WeatherData)
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
    
    func didFetchWeather(_ weather: WeatherData) {
        view?.showWeatherDetails(weather)
    }
}
