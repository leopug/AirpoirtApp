//
//  AirportDetailView.swift
//  AirportApp
//
//  Created by Leonardo Maia Pugliese on 30/04/21.
//

import UIKit

final class AirportDetailView: UIView {
    
    private var idLabel: UILabel!
    private var latitudeLabel: UILabel!
    private var longitudeLabel: UILabel!
    private var airportNameLabel: UILabel!
    private var cityNameLabel: UILabel!
    private var countryIdLabel: UILabel!
    private var nearestAirportLabel: UILabel!
    
    private var airport: Airport!
    private var airportNearest: AirportDistanceRelation!
    private var leadingPadding: CGFloat = 15
    private var trailingPadding: CGFloat = -15
    private var topPadding: CGFloat = 15
    
    
    init(airport: Airport, airportNearest: AirportDistanceRelation) {
        super.init(frame: .zero)
        self.airport = airport
        self.airportNearest = airportNearest
        backgroundColor = .systemBackground
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        configureIdLabel()
        configureLatitudeLabel()
        configureLongitudeLabel()
        configureAirportNameLabel()
        configureCityNameLabel()
        configureCountryIdLabel()
        configureNearestAirportLabel()
    }
    
    private func configureIdLabel() {
        idLabel = TitleLabel()
        addSubview(idLabel)
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        
        idLabel.text = "\(ContextStrings.Airport.Detail.idLabelTitle) \(airport.id)"
        
        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: topPadding),
            idLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingPadding)
        ])
    }
    
    private func configureLatitudeLabel() {
        latitudeLabel = TitleLabel()
        addSubview(latitudeLabel)
        latitudeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        latitudeLabel.text = "\(ContextStrings.Airport.Detail.latitudeLabelTitle) \(airport.latitude)"
        
        NSLayoutConstraint.activate([
            latitudeLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: topPadding),
            latitudeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingPadding)
        ])
    }
    
    private func configureLongitudeLabel() {
        longitudeLabel = TitleLabel()
        addSubview(longitudeLabel)
        longitudeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        longitudeLabel.text = "\(ContextStrings.Airport.Detail.longitudeLabelTitle) \(airport.longitude)"
        
        NSLayoutConstraint.activate([
            longitudeLabel.topAnchor.constraint(equalTo: latitudeLabel.bottomAnchor, constant: topPadding),
            longitudeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingPadding)
        ])
    }
    
    private func configureAirportNameLabel() {
        airportNameLabel = TitleLabel()
        addSubview(airportNameLabel)
        airportNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        airportNameLabel.text = "\(ContextStrings.Airport.Detail.airportNameLabelTitle) \(airport.name)"
        
        NSLayoutConstraint.activate([
            airportNameLabel.topAnchor.constraint(equalTo: longitudeLabel.bottomAnchor, constant: topPadding),
            airportNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingPadding),
            airportNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingPadding)
        ])
    }
    
    private func configureCityNameLabel() {
        cityNameLabel = TitleLabel()
        addSubview(cityNameLabel)
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cityNameLabel.text = "\(ContextStrings.Airport.Detail.cityLabelTitle) \(airport.city)"
        
        NSLayoutConstraint.activate([
            cityNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -trailingPadding),
            cityNameLabel.topAnchor.constraint(equalTo: airportNameLabel.bottomAnchor, constant: topPadding),
            cityNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingPadding)
        ])
    }
    
    private func configureCountryIdLabel() {
        countryIdLabel = TitleLabel()
        addSubview(countryIdLabel)
        countryIdLabel.translatesAutoresizingMaskIntoConstraints = false
        
        countryIdLabel.text = "\(ContextStrings.Airport.Detail.countryIdLabelTitle) \(airport.countryId)"
        
        NSLayoutConstraint.activate([
            countryIdLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: topPadding),
            countryIdLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingPadding)
        ])
    }
    
    private func configureNearestAirportLabel() {
        nearestAirportLabel = TitleLabel()
        addSubview(nearestAirportLabel)
        nearestAirportLabel.translatesAutoresizingMaskIntoConstraints = false
        
        updateNearestAirportLabel()
        
        NSLayoutConstraint.activate([
            nearestAirportLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingPadding),
            nearestAirportLabel.topAnchor.constraint(equalTo: countryIdLabel.bottomAnchor, constant: topPadding),
            nearestAirportLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingPadding)
        ])
    }
    
    func updateNearestAirportLabel() {
        nearestAirportLabel.text = "\(ContextStrings.Airport.Detail.nearestAirportLabelTitle) \(airportNearest.name) [ \(airportNearest.distanceInMeters.getFormattedDistance()) ]"
    }
}
