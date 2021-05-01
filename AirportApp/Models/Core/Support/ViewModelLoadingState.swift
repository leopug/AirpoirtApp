//
//  ViewModelLoadingState.swift
//  AirportApp
//
//  Created by Leonardo Maia Pugliese on 30/04/21.
//

import Foundation

enum ViewModelLoadingState {
    case loading
    case finishedLoading
    case error(Error)
}
