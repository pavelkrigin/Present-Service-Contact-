//
//  CityListPresenter.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import Foundation

protocol CityListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didFetchCities(_ cities: [City])
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
}
