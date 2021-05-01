//
//  Airport.swift
//  AirpoirtApp
//
//  Created by Leonardo Maia Pugliese on 29/04/21.
//

import Foundation

struct Airport: Decodable, Equatable {
    let id: String
    let latitude: Double
    let longitude: Double
    let name: String
    let city: String
    let countryId: String
    
    static func == (lhs: Airport, rhs: Airport) -> Bool {
        return lhs.id == rhs.id &&
            lhs.latitude == rhs.latitude &&
            lhs.longitude == rhs.longitude &&
            lhs.name == rhs.name &&
            lhs.city == rhs.city &&
            lhs.countryId == rhs.countryId
    }
}
