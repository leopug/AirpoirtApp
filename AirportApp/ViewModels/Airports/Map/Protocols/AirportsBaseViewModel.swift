//
//  AirportViewModelProtocol.swift
//  AirpoirtApp
//
//  Created by Leonardo Maia Pugliese on 29/04/21.
//

import Foundation
import Combine

protocol AirportsMapBaseViewModel {
    func getAnnotationPublisher() -> AnyPublisher<[AirportAnnotation],Never>
    func getAirportsMapViewModelStatePublisher() -> AnyPublisher<ViewModelLoadingState,Never>
    func getAirportPassthroughSubject() -> PassthroughSubject<Airport, Never>
}
