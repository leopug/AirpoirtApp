//
//  AirportDetailViewController.swift
//  AirportApp
//
//  Created by Leonardo Maia Pugliese on 29/04/21.
//

import UIKit

final class AirportDetailViewController: UIViewController {
    
    private var contentView: AirportDetailView!

    init(airport: Airport, airportNearest: AirportDistanceRelation) {
        super.init(nibName: nil, bundle: nil)
        contentView = AirportDetailView(airport: airport, airportNearest: airportNearest)
        title = ContextStrings.Airport.Detail.navigationAirportDetailTitle
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentView.updateNearestAirportLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
