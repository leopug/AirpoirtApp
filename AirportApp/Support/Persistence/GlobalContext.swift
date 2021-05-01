//
//  GlobalContext.swift
//  AirportApp
//
//  Created by Leonardo Maia Pugliese on 30/04/21.
//

import Foundation

struct GlobalContext {

    enum GlobalContextKeys: String {
        case metricType
    }
    
    @Persist(key: GlobalContextKeys.metricType.rawValue, defaultValue: false)
    static var isMilesSelected: Bool
}
