//
//  FlightsViewModelUtils.swift
//  AirportApp
//
//  Created by Leonardo Maia Pugliese on 01/05/21.
//

import Foundation
import CoreLocation

struct FlightsViewModelUtils {
    static func fetchFlightListResult(flightList: [Flight], selectedAirportId: String = "AMS", airportsList: [Airport]) -> [AirportDistanceRelation] {
        
        var arrivalAirportIdSet = Set<String>()
                
        flightList.forEach {
            if $0.departureAirportId == selectedAirportId {
                arrivalAirportIdSet.insert($0.arrivalAirportId)
            }
        }
        
        guard let selectedAirport = airportsList.first(where: {$0.id == selectedAirportId}) else {
            return [AirportDistanceRelation]()
        }
        
        return arrivalAirportIdSet.compactMap { (arrivalAirportId) -> AirportDistanceRelation? in
            let airportFound = airportsList.first { airport -> Bool in
                airport.id == arrivalAirportId
            }
            guard let airport = airportFound else { return nil }
            
            let selectedAirportLocation = CLLocation(latitude: selectedAirport.latitude, longitude: selectedAirport.longitude)
            let currentAirportLocation = CLLocation(latitude: airport.latitude, longitude: airport.longitude)
            
            return AirportDistanceRelation(name: airport.name, distanceInMeters: selectedAirportLocation.distance(from: currentAirportLocation))
        }.sorted { (lhs, rhs) -> Bool in
            lhs.distanceInMeters < rhs.distanceInMeters
        }
    }
}
