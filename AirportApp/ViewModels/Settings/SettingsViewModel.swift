//
//  SettingsViewModel.swift
//  AirportApp
//
//  Created by Leonardo Maia Pugliese on 30/04/21.
//

import Foundation
import Combine

final class SettingsViewModel: SettingsBaseViewModel {
    
    private var coordinator: SettingsBaseCoordinator!
    private var switchPassthroughSubject = PassthroughSubject<Bool, Never>()
    private var bindings = Set<AnyCancellable>()

    init(coordinator: SettingsBaseCoordinator) {
        self.coordinator = coordinator
        setupViewModelBindings()
    }
    
    func getSwitchPassthroughSubject() -> PassthroughSubject<Bool, Never> { switchPassthroughSubject }
    
    private func setupViewModelBindings() {
        switchPassthroughSubject.sink { isOn in
            GlobalContext.isMilesSelected = isOn
        }.store(in: &bindings)
    }
    
}
