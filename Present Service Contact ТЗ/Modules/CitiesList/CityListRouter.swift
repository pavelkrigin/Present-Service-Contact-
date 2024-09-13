//
//  CityListRouter.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import UIKit

final class CitiesListRouter {
    static func createModule() -> UIViewController {
        let interactor = CitiesListInteractor()
        let presenter = CitiesListPresenter(interactor: interactor)
        let viewController = CitiesListViewController(presenter: presenter)
        
        presenter.view = viewController
        interactor.presenter = presenter
        
        return viewController
    }
}
