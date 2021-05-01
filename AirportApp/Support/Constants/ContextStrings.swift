//
//  ContextStrings.swift
//  AirportApp
//
//  Created by Leonardo Maia Pugliese on 30/04/21.
//

import Foundation

struct ContextStrings {
    
    struct TabBar {
        static let airportsTabTitle = NSLocalizedString("airportsTabTitle", comment: "The airports tab title")
        static let flightsTabTitle = NSLocalizedString("flightsTabTitle", comment: "The flights tab title")
        static let settingsTabTitle = NSLocalizedString("settingsTabTitle", comment: "The settings tab title")
    }
    
    struct Airport {
        
        struct Map {
            static let navigationAirportsMapTitle = NSLocalizedString("navigationAirportsMapTitle", comment: "The airport title")
        }
        
        struct Detail {
            static let navigationAirportDetailTitle = NSLocalizedString("navigationAirportDetailTitle", comment: "The airport detail navigation title")
            static let idLabelTitle = NSLocalizedString("idLabelTitle", comment: "The ID label Title")
            static let latitudeLabelTitle = NSLocalizedString("latitudeLabelTitle", comment: "The latitute label title")
            static let longitudeLabelTitle = NSLocalizedString("longitudeLabelTitle", comment: "The latitute label title")
            static let airportNameLabelTitle = NSLocalizedString("airportNameLabelTitle", comment: "The latitute label title")
            static let cityLabelTitle = NSLocalizedString("cityLabelTitle", comment: "The city label title")
            static let countryIdLabelTitle = NSLocalizedString("countryIdLabelTitle", comment: "The country ID title")
            static let nearestAirportLabelTitle = NSLocalizedString("nearestAirportLabelTitle", comment: "The nearest airport label title")
        }
    }
    
    struct Flights {
        static let navigationFlightsTitle = NSLocalizedString("navigationFlightsTitle", comment: "The flight view navigation title")
    }
    
    struct Settings {
        static let navigationSettingsTitle = NSLocalizedString("navigationSettingsTitle", comment: "The settings view navigation title")
        static let milesLabelTitle = NSLocalizedString("milesLabelTitleSettings", comment: "The miles label title in settings")
    }
}
