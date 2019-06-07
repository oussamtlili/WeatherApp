//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Oussam Tlili on 07/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setRootViewController()
        
        return true
    }
}

private extension AppDelegate {
    func setRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewModel = WeatherListViewModel()
        let weatherListViewController = WeatherListViewController(viewModel: viewModel)
        window?.rootViewController = UINavigationController(rootViewController: weatherListViewController)
        window?.makeKeyAndVisible()
    }
}

