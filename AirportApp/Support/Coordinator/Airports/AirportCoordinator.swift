//
//  AirportsCoordinator.swift
//  AirpoirtApp
//
//  Created by Leonardo Maia Pugliese on 29/04/21.
//

import UIKit

final class AirportCoordinator: AirportBaseCoordinator {
    
    var rootViewController: UIViewController?
    
    func start() -> UIViewController {
        let airportsMapViewController = AirportsMapViewController(viewModel: AirportsMapViewModel(coordinator: self))
        let navigationController = UINavigationController(rootViewController: airportsMapViewController)
        rootViewController = navigationController
        return navigationController
    }
    
    func sendToAirportDetail(airport: Airport, airportNearest: AirportDistanceRelation) {
        (rootViewController as? UINavigationController)?.pushViewController(AirportDetailViewController(airport: airport, airportNearest: airportNearest), animated: false)
    }
}
