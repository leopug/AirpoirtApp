//
//  SettingsViewController.swift
//  AirportApp
//
//  Created by Leonardo Maia Pugliese on 30/04/21.
//

import UIKit
import Combine

final class SettingsViewController: UIViewController {

    private var viewModel: SettingsBaseViewModel!
    private var contentView: SettingsView!
    private var bindings = Set<AnyCancellable>()
    private var milesSwitchPassthroughSubject = PassthroughSubject<Bool, Never>()
    
    init(viewModel: SettingsBaseViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        title = ContextStrings.Settings.navigationSettingsTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        contentView = SettingsView(milesSwitchPassthroughSubject: milesSwitchPassthroughSubject)
        view = contentView
        configureViewModelBindings()
    }
    
    private func configureViewModelBindings() {
        configureMilesSwitchPassthroughSubject()
    }
    
    private func configureMilesSwitchPassthroughSubject() {
        milesSwitchPassthroughSubject.sink { isOn in
            self.viewModel.getSwitchPassthroughSubject().send(isOn)
        }.store(in: &bindings)
    }
    
}
