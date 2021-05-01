//
//  AirportMapUtils.swift
//  AirportApp
//
//  Created by Leonardo Maia Pugliese on 01/05/21.
//

import Foundation
import CoreLocation

struct AirportMapViewModelUtils {
    static func fetchNearestAirportInMeters(from airport: Airport, to airportAnnotationList: [AirportAnnotation]) -> AirportDistanceRelation? {
        
        let airportLocation = CLLocation(latitude: airport.latitude, longitude: airport.longitude)
        
        return airportAnnotationList
            .filter { airportAnnotation -> Bool in airportAnnotation.airport != airport}
            .map { (airportAnnotation) -> AirportDistanceRelation in
            AirportDistanceRelation(name: airportAnnotation.airport.name, distanceInMeters:  airportLocation.distance(from: CLLocation(latitude: airportAnnotation.airport.latitude, longitude: airportAnnotation.airport.longitude)))}
            .sorted {  $0.distanceInMeters < $1.distanceInMeters }.first
    }
}
