//
//  FlightsViewModelProtocol.swift
//  AirpoirtApp
//
//  Created by Leonardo Maia Pugliese on 29/04/21.
//

import Foundation

protocol FlightsViewModelProtocol {
    func getAirportDistanceRelationPublisher() -> Published<[AirportDistanceRelation]>.Publisher
    func getViewModelStatePublisher() -> Published<ViewModelLoadingState>.Publisher
}
