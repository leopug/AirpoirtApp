//
//  FlightsViewModel.swift
//  AirportApp
//
//  Created by Leonardo Maia Pugliese on 30/04/21.
//

import Foundation
import Combine
import CoreLocation

final class FlightsViewModel: FlightsViewModelProtocol {
    
    @Published private var state: ViewModelLoadingState = .loading
    @Published private var airportDistanceRelationList = [AirportDistanceRelation]()
    @Published private var airportsList = [Airport]()
    
    private var airportManager: AirportManagerProtocol!
    private var coordinator: FlightsBaseCoordinator!
    private var flightsManager: FlightsManagerProtocol!
    private var bindings = Set<AnyCancellable>()
    

    init(airportManager: AirportManagerProtocol = AirportManager(), flightsManager: FlightsManagerProtocol = FlightsManager(), coordinator: FlightsBaseCoordinator) {
        self.airportManager = airportManager
        self.coordinator = coordinator
        self.flightsManager = flightsManager
        
        state = .loading
        
        setupViewModelBindings(airportManager: airportManager, flightsManager: flightsManager)
    }

    func getAirportDistanceRelationPublisher() -> Published<[AirportDistanceRelation]>.Publisher { $airportDistanceRelationList }
    
    func getViewModelStatePublisher() -> Published<ViewModelLoadingState>.Publisher { $state }
    
    private func setupViewModelBindings(airportManager: AirportManagerProtocol, flightsManager: FlightsManagerProtocol) {
        $airportsList.sink {[weak self] _ in
            self?.setupFlightsManagerBinding(flightsManager: flightsManager)
        }.store(in: &bindings)
        
        setupAirportManagerBinding(airportManager)
    }
    
    private func setupFlightsManagerBinding(flightsManager: FlightsManagerProtocol) {
        
        flightsManager.getAirportsDistanceRelation().sink { [weak self] completion in
            switch completion {
            case .finished:
                self?.state = .finishedLoading
            case .failure(let error):
                self?.state = .finishedLoading
                self?.state = .error(error)
            }
        } receiveValue: { flightList in
            
            guard self.airportsList.count > 0 else {
                self.state = .error(FlightError.parsingProblem)
                return
            }
            
            let airportDistanceRelationListResult = FlightsViewModelUtils.fetchFlightListResult(flightList: flightList,airportsList: self.airportsList)
            
            if airportDistanceRelationListResult.count > 0 {
                self.airportDistanceRelationList = airportDistanceRelationListResult
            } else {
                self.state = .error(FlightError.noNearAirport)
            }
        }.store(in: &bindings)
    }
    
    private func setupAirportManagerBinding(_ airportManager: AirportManagerProtocol) {
        airportManager.getAirports().sink { [weak self] completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                self?.state = .finishedLoading
                self?.state = .error(error)
            }
        } receiveValue: { (airportList) in
            self.airportsList = airportList
        }.store(in: &bindings)
    }
}
