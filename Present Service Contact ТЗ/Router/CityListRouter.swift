//
//  CityListRouter.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import UIKit

protocol CityListRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func navigateToCitySearch(from view: CityListViewProtocol)
    func navigateToCityDetail(from view: CityListViewProtocol, for city: String)
}

class CityListRouter: CityListRouterProtocol {
    static func createModule() -> UIViewController {
        let view = CityListViewController()
        let presenter: CityListPresenterProtocol & CityListInteractorOutputProtocol = CityListPresenter()
        let interactor: CityListInteractorProtocol = CityListInteractor()
        let router: CityListRouterProtocol = CityListRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    func navigateToCitySearch(from view: CityListViewProtocol) {
        let searchVC = SearchCityRouter.createModule(cityListInteractor: view.presenter!.interactor as! CityListInteractor)
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(searchVC, animated: true)
        }
    }
    
    func navigateToCityDetail(from view: CityListViewProtocol, for city: String) {
        let cityDetailVC = CityDetailRouter.createModule(for: city)
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(cityDetailVC, animated: true)
        }
    }
}
