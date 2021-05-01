//
//  SettingsView.swift
//  AirportApp
//
//  Created by Leonardo Maia Pugliese on 30/04/21.
//

import UIKit
import Combine

class SettingsView: UIView {

    private var milesSwitchLabel: TitleLabel!
    private var milesSwitch: UISwitch!
    
    private var milesSwitchPassthroughSubject: PassthroughSubject<Bool, Never>!
    
    private let topPadding: CGFloat = 30
    private let leadingPadding: CGFloat = 30
    
    init(milesSwitchPassthroughSubject: PassthroughSubject<Bool, Never>) {
        super.init(frame: .zero)
        self.milesSwitchPassthroughSubject = milesSwitchPassthroughSubject
        backgroundColor = .systemBackground
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        configureMilesSwitchLabel()
        configureMilesSwitch()
    }
    
    private func configureMilesSwitchLabel() {
        milesSwitchLabel = TitleLabel()
        addSubview(milesSwitchLabel)
        milesSwitchLabel.translatesAutoresizingMaskIntoConstraints = false
        
        milesSwitchLabel.text = ContextStrings.Settings.milesLabelTitle
        
        NSLayoutConstraint.activate([
            milesSwitchLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: topPadding),
            milesSwitchLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingPadding)
        ])
        
    }
    
    private func configureMilesSwitch() {
        milesSwitch = UISwitch()
        addSubview(milesSwitch)
        milesSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        milesSwitch.addTarget(self, action: #selector(self.switchStateDidChange(_:)), for: .valueChanged)
        milesSwitch.setOn(GlobalContext.isMilesSelected, animated: false)
        
        NSLayoutConstraint.activate([
            milesSwitch.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: topPadding),
            milesSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -leadingPadding)
        ])

    }
    
    @objc func switchStateDidChange(_ sender:UISwitch!) {
        milesSwitchPassthroughSubject.send(sender.isOn == true)
    }
}
