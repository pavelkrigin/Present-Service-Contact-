//
//  AppDelegate.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Создаем UIWindow
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: CityListRouter.createModule())
        
        // Устанавливаем rootViewController как UINavigationController
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

