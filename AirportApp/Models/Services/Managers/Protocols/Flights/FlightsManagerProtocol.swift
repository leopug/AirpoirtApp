//
//  FlightsManagerProtocol.swift
//  AirportApp
//
//  Created by Leonardo Maia Pugliese on 30/04/21.
//

import Combine
import Foundation

protocol FlightsManagerProtocol {
    func getAirportsDistanceRelation() -> AnyPublisher<[Flight], Error>
}
