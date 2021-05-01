//
//  AirpoirtsBaseCoordinator.swift
//  AirpoirtApp
//
//  Created by Leonardo Maia Pugliese on 29/04/21.
//

import UIKit

protocol AirportBaseCoordinator: Coordinator {
    func sendToAirportDetail(airport: Airport, airportNearest: AirportDistanceRelation)
}
