//
//  BodyLabel.swift
//  AirportApp
//
//  Created by Leonardo Maia Pugliese on 30/04/21.
//

import UIKit

class BodyLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        textColor = .label
        font = .systemFont(ofSize: 18)
        numberOfLines = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
