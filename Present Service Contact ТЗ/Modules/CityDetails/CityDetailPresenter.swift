//
//  CityDetailPresenter.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import Foundation

// MARK: - Protocol
protocol CityDetailPresenterInput {
    func loadWeatherDetail()
}

protocol CityDetailPresenterOutput: AnyObject {
    func showWeatherDetail(_ weatherDetails: [WeatherDetail])
    func showError(_ error: Error)
}

// MARK: - Class
final class CityDetailPresenter: CityDetailPresenterInput {
    private let interactor: CityDetailInteractorInput
    private let city: String
    private let days: Int
    weak var view: CityDetailPresenterOutput?
    
    init(interactor: CityDetailInteractorInput, city: String, days: Int) {
        self.interactor = interactor
        self.city = city
        self.days = days
    }
    
    func loadWeatherDetail() {
        interactor.fetchWeatherDetail(for: city, days: days)
    }
}

// MARK: - Extension
extension CityDetailPresenter: CityDetailInteractorOutput {
    func didFetchWeatherDetail(_ weatherDetails: [WeatherDetail]) {
        view?.showWeatherDetail(weatherDetails)
    }
    
    func didFailFetchingWeatherDetail(with error: Error) {
        view?.showError(error)
    }
}
