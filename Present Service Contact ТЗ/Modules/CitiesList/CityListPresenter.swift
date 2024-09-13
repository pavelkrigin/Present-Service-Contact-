//
//  CityListPresenter.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import Foundation

protocol CitiesListPresenterInput {
    func loadCitiesWeather()
}

protocol CitiesListPresenterOutput: AnyObject {
    func showCitiesWeather(_ citiesWeather: [String: Double])
    func showError(_ error: Error)
}

final class CitiesListPresenter: CitiesListPresenterInput {
    private let interactor: CitiesListInteractorInput
    weak var view: CitiesListPresenterOutput?
    
    private var cities = ["London", "Moscow", "New York"]
    
    init(interactor: CitiesListInteractorInput) {
        self.interactor = interactor
    }

    func loadCitiesWeather() {
        interactor.fetchWeatherForCities(cities)
    }
}

extension CitiesListPresenter: CitiesListInteractorOutput {
    func didFetchWeatherData(_ data: [String: Double]) {
        view?.showCitiesWeather(data)
    }
}
