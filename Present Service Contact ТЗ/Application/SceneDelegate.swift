//
//  SceneDelegate.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let citiesListVC = CitiesListRouter.createModule()
        let navigationController = UINavigationController(rootViewController: citiesListVC)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}
