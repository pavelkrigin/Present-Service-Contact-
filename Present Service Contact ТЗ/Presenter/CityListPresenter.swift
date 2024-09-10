//
//  CityListPresenter.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import Foundation

protocol SearchCityPresenterProtocol: AnyObject {
    func searchCity(_ cityName: String)
    func didFetchCity(_ city: City)
    func didFailToFetchCity(_ error: String)
}

class SearchCityPresenter: SearchCityPresenterProtocol {
    weak var view: SearchCityViewProtocol?
    var interactor: SearchCityInteractorProtocol?
    var router: SearchCityRouterProtocol?
    var cityListInteractor: CityListInteractorProtocol?
    
    func searchCity(_ cityName: String) {
        interactor?.searchCity(cityName)
    }
    
    func didFetchCity(_ city: City) {
        cityListInteractor?.saveCity(city)
        router?.dismissSearch()
    }
    
    func didFailToFetchCity(_ error: String) {
        view?.showError(error)
    }
}

protocol CityListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didFetchCities(_ cities: [City])
    func showCityDetail(for city: String)
}

class CityListPresenter: CityListPresenterProtocol {
    weak var view: CityListViewProtocol?
    var interactor: CityListInteractorProtocol?
    var router: CityListRouterProtocol?
    
    func viewDidLoad() {
        interactor?.fetchCities()
    }
    
    func didFetchCities(_ cities: [City]) {
        view?.showCities(cities)
    }
    
    func showCityDetail(for city: String) {
        router?.navigateToCityDetail(from: view!, for: city)
    }
}
