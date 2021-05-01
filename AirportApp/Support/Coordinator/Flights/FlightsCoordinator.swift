//
//  FlightsCoordinator.swift
//  AirpoirtApp
//
//  Created by Leonardo Maia Pugliese on 29/04/21.
//

import UIKit

class FlightsCoordinator: FlightsBaseCoordinator {
    
    var rootViewController: UIViewController?
    
    func start() -> UIViewController {
        let flightsViewController = FlightsViewController(viewModel: FlightsViewModel(coordinator: self))
        let navigationController = UINavigationController(rootViewController: flightsViewController)
        rootViewController = navigationController
        return navigationController
    }
    
    
}
