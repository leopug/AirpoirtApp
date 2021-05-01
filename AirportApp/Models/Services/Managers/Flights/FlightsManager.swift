//
//  FlightsManager.swift
//  AirportApp
//
//  Created by Leonardo Maia Pugliese on 30/04/21.
//

import Foundation
import Combine

final class FlightsManager: FlightsManagerProtocol {
    
    func getAirportsDistanceRelation() -> AnyPublisher<[Flight], Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        return Future<[Flight], Error> { promise in
            guard let urlRequest = UrlRequestManager.getUrlRequest(for: .flights) else {
                promise(.failure(ApiError.urlRequest))
                return
            }
            
            dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                guard let data = data else {
                    if let error = error {
                        promise(.failure(error))
                    }
                    return
                }
                
                let response = response as! HTTPURLResponse
                
                guard (200...299).contains(response.statusCode) else {
                    promise(.failure(ApiError.networkProblem))
                    return
                }
                
                do {
                    let flightList = try JSONDecoder().decode([Flight].self, from: data)
                    promise(.success(flightList))
                } catch {
                    promise(.failure(ApiError.decode))
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
