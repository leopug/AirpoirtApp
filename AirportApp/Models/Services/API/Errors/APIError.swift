//
//  APIErrors.swift
//  AirportApp
//
//  Created by Leonardo Maia Pugliese on 29/04/21.
//

import Foundation

enum ApiError: Error {
    case url(URLError)
    case urlRequest
    case networkProblem
    case decode
}
