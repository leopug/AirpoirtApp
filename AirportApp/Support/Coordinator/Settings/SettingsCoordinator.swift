//
//  SettingsCoordinator.swift
//  AirportApp
//
//  Created by Leonardo Maia Pugliese on 30/04/21.
//

import UIKit

class SettingsCoordinator: SettingsBaseCoordinator {
    
    var rootViewController: UIViewController?
    
    func start() -> UIViewController {
        let flightsViewController = SettingsViewController(viewModel: SettingsViewModel(coordinator: self))
        let navigationController = UINavigationController(rootViewController: flightsViewController)
        rootViewController = navigationController
        return navigationController
    }
    
    
}
