//
//  SettingsBaseViewModel.swift
//  AirportApp
//
//  Created by Leonardo Maia Pugliese on 30/04/21.
//

import Foundation
import Combine

protocol SettingsBaseViewModel {
    func getSwitchPassthroughSubject() -> PassthroughSubject<Bool, Never>
}
