//
//  AirportAnnotation.swift
//  AirpoirtApp
//
//  Created by Leonardo Maia Pugliese on 29/04/21.
//

import Foundation
import CoreLocation
import MapKit

final class AirportAnnotation: MKPointAnnotation {
    var airport: Airport

    init(airport: Airport) {
        self.airport = airport
        super.init()
        self.coordinate = CLLocationCoordinate2D(latitude: airport.latitude, longitude: airport.longitude)
        self.title = airport.name
    }
}
