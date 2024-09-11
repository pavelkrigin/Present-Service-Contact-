//
//  SearchCityPresenter.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 11.09.2024.
//

import Foundation

protocol SearchCityPresenterProtocol: AnyObject {
    func searchCity(_ city: String)
}

class SearchCityPresenter: SearchCityPresenterProtocol {
    weak var view: SearchCityViewProtocol?
    var interactor: SearchCityInteractorProtocol?
    var cityListInteractor: SearchCityInteractorOutputProtocol?
    
    func searchCity(_ city: String) {
        interactor?.fetchWeather(for: city)
    }
}

extension SearchCityPresenter: SearchCityInteractorOutputProtocol {
    func didFetchWeather(_ weather: WeatherData) {
        let city = City(name: weather.name, temperature: weather.main.temp)
        cityListInteractor?.saveCity(city)
    }
    
    func didFailWithError(_ error: WeatherError) {
        switch error {
        case .cityNotFound:
            view?.showError("City not found. Please try again.")
        case .networkError:
            view?.showError("Network error. Please check your connection.")
        case .unknownError:
            view?.showError("Something went wrong. Please try again.")
        }
    }
}
