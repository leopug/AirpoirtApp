//
//  MainBaseCoordinator.swift
//  AirpoirtApp
//
//  Created by Leonardo Maia Pugliese on 29/04/21.
//

import UIKit

protocol MainBaseCoordinator: Coordinator {
    var airportsCoordinator: AirportBaseCoordinator? { get }
    var flightsCoordinator: FlightsBaseCoordinator? { get }
    var settingsCoordinator: SettingsBaseCoordinator? { get }
}
