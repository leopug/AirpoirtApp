//
//  AirportDistanceTableViewCell.swift
//  AirportApp
//
//  Created by Leonardo Maia Pugliese on 30/04/21.
//

import UIKit

class AirportDistanceTableViewCell: UITableViewCell {
    
    static let reuseId = "AirportDistanceTableViewCell"
    
    private var airportNameLabel: BodyLabel!
    private var airportDistanceLabel: BodyLabel!
    private let topPadding: CGFloat = 15
    private let leadingPadding: CGFloat = 15
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        selectionStyle = .none
        configureAirportNameLabel()
        configureAirportDistanceLabel()
    }
    
    private func configureAirportNameLabel() {
        airportNameLabel = BodyLabel()
        contentView.addSubview(airportNameLabel)
        airportNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            airportNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topPadding),
            airportNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leadingPadding),
            airportNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -topPadding)
        ])
    }
    
    private func configureAirportDistanceLabel() {
        airportDistanceLabel = BodyLabel()
        contentView.addSubview(airportDistanceLabel)
        airportDistanceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        airportDistanceLabel.textAlignment = .right
        airportDistanceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        NSLayoutConstraint.activate([
            airportDistanceLabel.centerYAnchor.constraint(equalTo: airportNameLabel.centerYAnchor),
            airportDistanceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -leadingPadding),
            airportDistanceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: airportNameLabel.trailingAnchor)
        ])
    }
    
    func configureCell(airportName: String, airportDistanceInMeters: Double) {
        airportNameLabel.text = airportName
        airportDistanceLabel.text = airportDistanceInMeters.getFormattedDistance()
    }
    
}
