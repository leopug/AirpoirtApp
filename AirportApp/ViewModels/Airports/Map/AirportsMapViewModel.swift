//
//  AirportsMapViewModel.swift
//  AirpoirtApp
//
//  Created by Leonardo Maia Pugliese on 29/04/21.
//

import Foundation
import Combine
import CoreLocation

final class AirportsMapViewModel: AirportsMapBaseViewModel {

    @Published private var state: ViewModelLoadingState = .loading
    @Published private var annotations = [AirportAnnotation]()
    private var airportManager: AirportManagerProtocol!
    private var coordinator: AirportsBaseCoordinator!
    private var bindings = Set<AnyCancellable>()
    private var airportPassthroughSubject = PassthroughSubject<(Airport), Never>()
    
    init(airportManager: AirportManagerProtocol = AirportManager(), coordinator: AirportsBaseCoordinator) {
        self.airportManager = airportManager
        self.coordinator = coordinator
        state = .loading
        
        setupViewModelBindings(airportManager, coordinator)
    }
    
    func getAnnotationPublisher() -> AnyPublisher<[AirportAnnotation],Never> { $annotations.eraseToAnyPublisher() }
    
    func getAirportsMapViewModelStatePublisher() -> AnyPublisher<ViewModelLoadingState,Never> { $state.eraseToAnyPublisher() }
    
    func getAirportPassthroughSubject() -> PassthroughSubject<(Airport), Never> { airportPassthroughSubject }
    
    private func fetchNearestAirportInMeters(from airport: Airport, to airportAnnotationList: [AirportAnnotation]) -> AirportDistanceRelation? {
        
        let airportLocation = CLLocation(latitude: airport.latitude, longitude: airport.longitude)
        
        return airportAnnotationList.filter { airportAnnotation -> Bool in
            airportAnnotation.airport != airport
        }.map { (airportAnnotation) -> AirportDistanceRelation in
            AirportDistanceRelation(name: airportAnnotation.airport.name, distanceInMeters:  airportLocation.distance(from: CLLocation(latitude: airportAnnotation.airport.latitude, longitude: airportAnnotation.airport.longitude)))
        }.sorted {  $0.distanceInMeters < $1.distanceInMeters }.first
    }
    
    private func setupViewModelBindings(_ airportManager: AirportManagerProtocol, _ coordinator: AirportsBaseCoordinator) {
        
        airportManager.getAirports().sink { [weak self] completion in
            switch completion {
            case .finished:
                self?.state = .finishedLoading
            case .failure(let error):
                self?.state = .error(error)
            }
        } receiveValue: {[weak self] (airportList) in
            self?.annotations = airportList.map {
                AirportAnnotation(airport: $0)
            }
        }.store(in: &bindings)
        
        airportPassthroughSubject.sink { [weak self] airport in
            guard let annotations = self?.annotations else {
                self?.state = .error(MapError.noAirportsSaved)
                return
            }
            if let nearestAirportRelation = self?.fetchNearestAirportInMeters(from: airport, to: annotations) {
                coordinator.sendToAirportDetail(airport: airport, airportNearest: nearestAirportRelation)
            }
            
        }.store(in: &bindings)
    }
    
}
