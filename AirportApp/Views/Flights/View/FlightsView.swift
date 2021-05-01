//
//  FlightsView.swift
//  AirportApp
//
//  Created by Leonardo Maia Pugliese on 30/04/21.
//

import UIKit
import Combine

class FlightsView: UIView {
    
    private var flightsTableView: UITableView!
    private var activityIndicationView: ActivityIndicatorView!

    private var airportDistanceRelationList = [AirportDistanceRelation]()

    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        configureActivityIndicatorView()
        configureFlightsTableView()
    }
    
    private func configureActivityIndicatorView() {
        activityIndicationView = ActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        addSubview(activityIndicationView)
        activityIndicationView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicationView.heightAnchor.constraint(equalToConstant: 40),
            activityIndicationView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureFlightsTableView() {
        flightsTableView = UITableView()
        addSubview(flightsTableView)
        flightsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        flightsTableView.separatorStyle = .none
        flightsTableView.dataSource = self
        flightsTableView.register(AirportDistanceTableViewCell.self, forCellReuseIdentifier: AirportDistanceTableViewCell.reuseId)
        
        NSLayoutConstraint.activate([
            flightsTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            flightsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            flightsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            flightsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setAirportDistanceRelationList(_ airportDistanceRelationList: [AirportDistanceRelation]) {
        self.airportDistanceRelationList = airportDistanceRelationList
    }
    
    func reloadData() {
        flightsTableView.reloadData()
    }
    
    func startLoading() {
        activityIndicationView.isHidden = false
        activityIndicationView.startAnimating()
    }
    
    func finishLoading() {
        activityIndicationView.stopAnimating()
    }
}

extension FlightsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        airportDistanceRelationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AirportDistanceTableViewCell.reuseId, for: indexPath) as? AirportDistanceTableViewCell else { return UITableViewCell()}
        
        cell.configureCell(airportName: airportDistanceRelationList[indexPath.row].name, airportDistanceInMeters: airportDistanceRelationList[indexPath.row].distanceInMeters)
        
        return cell
    }
}
