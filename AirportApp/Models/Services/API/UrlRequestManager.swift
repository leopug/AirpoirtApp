//
//  UrlRequestManager.swift
//  AirportApp
//
//  Created by Leonardo Maia Pugliese on 29/04/21.
//

import Foundation

enum Endpoint: String {
    case airpoirt = "/test/airports.json"
    case flights = "/test/flights.json"
    
    func getScheme() -> String { "https" }
    
    func getHost() -> String { "flightassets.datasavannah.com" }
}

struct UrlRequestManager {
    
    static func getUrlRequest(for endpoint: Endpoint) -> URLRequest? {
        var components = URLComponents()
        components.scheme = endpoint.getScheme()
        components.host = endpoint.getHost()
        components.path = endpoint.rawValue
        
        guard let url = components.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = 10.0
        urlRequest.httpMethod = "GET"

        return urlRequest
    }
}
