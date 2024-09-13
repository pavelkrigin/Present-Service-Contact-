//
//  CityListPresenter.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import Foundation

// MARK: - CitiesListPresenterInput
protocol CitiesListPresenterInput: AnyObject {
    func loadCitiesWeather()
}

// MARK: - CitiesListPresenterOutput
protocol CitiesListPresenterOutput: AnyObject {
    func showCitiesWeather(_ citiesWeather: [String: Double])
    func showError(_ error: Error)
}

final class CitiesListPresenter: CitiesListPresenterInput {
    private let interactor: CitiesListInteractorInput
    weak var view: CitiesListPresenterOutput?
    
    private var cities = ["London", "Moscow", "New York"] // Список городов по умолчанию

    init(interactor: CitiesListInteractorInput) {
        self.interactor = interactor
    }

    // Метод для загрузки погоды для городов
    func loadCitiesWeather() {
        interactor.fetchWeatherForCities(cities)
    }
}

extension CitiesListPresenter: CitiesListInteractorOutput {
    // Метод для получения данных о погоде от Interactor
    func didFetchWeatherData(_ data: [String: Double]) {
        view?.showCitiesWeather(data)
    }
    
    // Метод для обработки ошибки от Interactor
    func didFailFetchingWeatherData(with error: Error) {
        view?.showError(error)
    }
}
