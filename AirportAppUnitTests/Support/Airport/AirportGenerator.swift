//
//  AirportGenerator.swift
//  AirportAppUnitTests
//
//  Created by Leonardo Maia Pugliese on 01/05/21.
//
@testable import AirportApp
import Combine
import UIKit

struct AirportGenerator {
    
    static func generateAirportManagerSuccesfullReturn() -> AirportManagerProtocol { AirportManagerSuccesfullReturnMock() }
    
    static func generateAirportManagerEmptyReturn() -> AirportManagerProtocol { AirportManagerEmptyListReturnMock() }
    
    static func generateAirportCoordinatorMock() -> AirportsBaseCoordinator { AirportsCoordinatorMock() }
    
    static func generateAirportListWithThreeElements() -> [Airport] {
        [Airport(id: "GRU", latitude: -23.4322, longitude: -46.4692, name: "Guarulhos Aeroporto", city: "Sao Paulo", countryId: "BR"),
         Airport(id: "SDU", latitude: -22.4322, longitude: -46.4692, name: "Santo Dummond Aeroporto", city: "Rio De Janeiro", countryId: "BR"),
         Airport(id: "COM", latitude: -19.4322, longitude: -46.4692, name: "Combica Aeroporto", city: "Sao Paulo", countryId: "BR")]
    }
    
    static func generateAirportListAnnotationWithThreeElements() -> [AirportAnnotation] {
        generateAirportListWithThreeElements().map { AirportAnnotation(airport: $0) }
    }
}


extension AirportGenerator {
    
    private struct AirportManagerSuccesfullReturnMock: AirportManagerProtocol {
        
        func getAirports() -> AnyPublisher<[Airport], Error> {
            
            return Future<[Airport], Error> { promise in
                
                let airportList = generateAirportListWithThreeElements()
                
                        promise(.success(airportList))
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        }
    }
    
    private struct AirportManagerEmptyListReturnMock: AirportManagerProtocol {
        
        func getAirports() -> AnyPublisher<[Airport], Error> {
            
            return Future<[Airport], Error> { promise in
                promise(.success([]))
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        }
    }
    
    private struct AirportsCoordinatorMock: AirportsBaseCoordinator {
        
        func sendToAirportDetail(airport: Airport, airportNearest: AirportDistanceRelation) {
            print("\(airport) \(airportNearest)")
        }
        
        var rootViewController: UIViewController?
        
        func start() -> UIViewController {
            let viewController = UIViewController()
            return viewController
        }
    }
    
}
