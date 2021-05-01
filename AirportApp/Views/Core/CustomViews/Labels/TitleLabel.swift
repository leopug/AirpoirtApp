//
//  TitleLabel.swift
//  AirportApp
//
//  Created by Leonardo Maia Pugliese on 30/04/21.
//

import UIKit

class TitleLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        textColor = .label
        font = .systemFont(ofSize: 24)
        numberOfLines = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
