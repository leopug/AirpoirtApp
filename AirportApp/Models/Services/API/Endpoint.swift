//
//  Endpoint.swift
//  AirportApp
//
//  Created by Leonardo Maia Pugliese on 01/05/21.
//

import Foundation

enum Endpoint: String {
    case airpoirt = "/test/airports.json"
    case flights = "/test/flights.json"
    
    func getScheme() -> String { "https" }
    
    func getHost() -> String { "flightassets.datasavannah.com" }
}
