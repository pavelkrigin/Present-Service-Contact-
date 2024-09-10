//
//  CityListRouter.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import UIKit

protocol CityListRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}

class CityListRouter: CityListRouterProtocol {
    static func createModule() -> UIViewController {
        let view = CityListViewController()
        let presenter: CityListPresenterProtocol & CityListInteractorProtocol = CityListPresenter()
        let interactor: CityListInteractorProtocol = CityListInteractor()
        let router: CityListRouterProtocol = CityListRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return view
    }
}
