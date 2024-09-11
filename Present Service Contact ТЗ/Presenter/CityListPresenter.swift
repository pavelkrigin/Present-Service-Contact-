//
//  CityListPresenter.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import Foundation

protocol CityListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func showCitySearch()
    func showCityDetail(for city: String)
}

class CityListPresenter: CityListPresenterProtocol {
    weak var view: CityListViewProtocol?
    var interactor: CityListInteractorProtocol?
    var router: CityListRouterProtocol?
    
    func viewDidLoad() {
        interactor?.fetchCities()
    }
    
    func showCitySearch() {
        router?.navigateToCitySearch(from: view!)
    }
    
    func showCityDetail(for city: String) {
        router?.navigateToCityDetail(from: view!, for: city)
    }
}

extension CityListPresenter: CityListInteractorOutputProtocol {
    func didFetchCities(_ cities: [City]) {
        view?.showCities(cities)
    }
}
