//
//  AirportManagerProtocol.swift
//  AirpoirtApp
//
//  Created by Leonardo Maia Pugliese on 29/04/21.
//

import Combine
import Foundation

protocol AirportManagerProtocol {
    func getAirports() -> AnyPublisher<[Airport], Error>
}
