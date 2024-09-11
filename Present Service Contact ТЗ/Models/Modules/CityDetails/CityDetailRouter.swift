//
//  CityDetailRouter.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import UIKit

protocol CityDetailRouterProtocol: AnyObject {
    static func createModule(for city: String) -> UIViewController
}

class CityDetailRouter: CityDetailRouterProtocol {
    static func createModule(for city: String) -> UIViewController {
        let view = CityDetailViewController()
        let presenter = CityDetailPresenter(cityName: city)
        let interactor = CityDetailInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}
