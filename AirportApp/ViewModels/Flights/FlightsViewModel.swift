//
//  FlightsViewModel.swift
//  AirportApp
//
//  Created by Leonardo Maia Pugliese on 30/04/21.
//

import Foundation
import Combine
import CoreLocation

class FlightsViewModel: FlightsViewModelProtocol {
    
    @Published private var state: ViewModelLoadingState = .loading
    @Published private var airportDistanceRelationList = [AirportDistanceRelation]()
    
    private var airportManager: AirportManagerProtocol!
    private var coordinator: FlightsBaseCoordinator!
    private var flightsManager: FlightsManagerProtocol!
    private var bindings = Set<AnyCancellable>()
    
    @Published private var airportsList = [Airport]()

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
        
        //                self?.state = .finishedLoading
        //                self?.state = .finishedLoading
        //                self?.state = .finishedLoading

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
            self.airportDistanceRelationList = self.fetchFlightListResult(flightList: flightList)
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
    
    private func fetchFlightListResult(flightList: [Flight], selectedAirportId: String = "AMS") -> [AirportDistanceRelation] {
        guard airportsList.count > 0 else {
            state = .error(FlightError.parsingProblem)
            return [AirportDistanceRelation]()
        }
        var arrivalAirportIdSet = Set<String>()
                
        flightList.forEach {
            if $0.departureAirportId == selectedAirportId {
                arrivalAirportIdSet.insert($0.arrivalAirportId)
            }
        }
        
        guard let currentSchipholAirport = airportsList.first(where: {$0.id == selectedAirportId}) else {
            state = .error(FlightError.parsingProblem)
            return [AirportDistanceRelation]()
        }
        
        return arrivalAirportIdSet.compactMap { (arrivalAirportId) -> AirportDistanceRelation? in
            let airportFound = airportsList.first { airport -> Bool in
                airport.id == arrivalAirportId
            }
            guard let airport = airportFound else { return nil }
            
            let schipholAirportLocation = CLLocation(latitude: currentSchipholAirport.latitude, longitude: currentSchipholAirport.longitude)
            let currentAirportLocation = CLLocation(latitude: airport.latitude, longitude: airport.longitude)
            
            return AirportDistanceRelation(name: airport.name, distanceInMeters: schipholAirportLocation.distance(from: currentAirportLocation))
        }.sorted { (lhs, rhs) -> Bool in
            lhs.distanceInMeters < rhs.distanceInMeters
        }
        
    }
}
