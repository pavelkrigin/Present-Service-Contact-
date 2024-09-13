//
//  CityDetailRouter.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import UIKit

final class CityDetailRouter {
    static func createModule(for city: String, days: Int) -> UIViewController {
        let interactor = CityDetailInteractor()
        let presenter = CityDetailPresenter(interactor: interactor, city: city, days: days)
        let viewController = CityDetailViewController(presenter: presenter)
        
        presenter.view = viewController
        interactor.presenter = presenter
        
        return viewController
    }
}
