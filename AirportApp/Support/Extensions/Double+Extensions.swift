//
//  Double+Extensions.swift
//  AirportApp
//
//  Created by Leonardo Maia Pugliese on 30/04/21.
//

import Foundation

extension Double {
    func getFormattedDistance() -> String {
        if !GlobalContext.isMilesSelected {
            return String(format: "%.2f", self/1000) + " km."
        } else {
            return String(format: "%.2f", self/1609.34) + " mi."
        }
    }
}
