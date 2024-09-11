//
//  SearchCityRouter.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 11.09.2024.
//

import UIKit

protocol SearchCityRouterProtocol: AnyObject {
    static func createModule(cityListInteractor: SearchCityInteractorProtocol) -> UIViewController
}

class SearchCityRouter: SearchCityRouterProtocol {
    static func createModule(cityListInteractor: SearchCityInteractorProtocol) -> UIViewController {
        let view = SearchCityViewController()
        let presenter = SearchCityPresenter()
        let interactor = SearchCityInteractor()
        let router: SearchCityRouterProtocol = SearchCityRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.cityListInteractor = cityListInteractor
        interactor.presenter = presenter
        
        return view
    }
}
