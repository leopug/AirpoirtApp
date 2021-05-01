//
//  AirportManager.swift
//  AirpoirtApp
//
//  Created by Leonardo Maia Pugliese on 29/04/21.
//

import Foundation
import Combine

final class AirportManager: AirportManagerProtocol {
    
    func getAirports() -> AnyPublisher<[Airport], Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        return Future<[Airport], Error> { promise in
            guard let urlRequest = UrlRequestManager.getUrlRequest(for: .airpoirt) else {
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
                    let airportList = try JSONDecoder().decode([Airport].self, from: data)
                    promise(.success(airportList))
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
