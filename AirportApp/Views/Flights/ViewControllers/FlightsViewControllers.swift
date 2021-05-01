//
//  FlightsViewControllers.swift
//  AirpoirtApp
//
//  Created by Leonardo Maia Pugliese on 29/04/21.
//

import UIKit
import Combine

final class FlightsViewController: UIViewController {
    
    private var viewModel: FlightsViewModelProtocol!
    private var contentView: FlightsView!
    private var bindings = Set<AnyCancellable>()
    
    @Published private var airportDistanceRelationList = [AirportDistanceRelation]()
    
    init(viewModel: FlightsViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        title = ContextStrings.Flights.navigationFlightsTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentView.reloadData()
    }
    
    override func loadView() {
        contentView = FlightsView()
        view = contentView
        configureViewModelBindings()
    }
    
    private func configureViewModelBindings() {
        configureStateBinding()
        configureAirportDistanceRelationBinding()
    }
    
    private func configureAirportDistanceRelationBinding() {
        viewModel
            .getAirportDistanceRelationPublisher()
            .sink { [weak self] airportDistanceRelationList in
                self?.contentView.setAirportDistanceRelationList(airportDistanceRelationList)
            }.store(in: &bindings)
    }
    
    fileprivate func configureStateBinding() {
        let stateValueHandler: (ViewModelLoadingState) -> Void = { [weak self] state in
            switch state {
            case .loading:
                self?.contentView.startLoading()
            case .finishedLoading:
                self?.contentView.finishLoading()
            case .error(let error):
                self?.contentView.finishLoading()
                self?.showError(error)
            }
        }
        
        viewModel
            .getViewModelStatePublisher()
            .receive(on: RunLoop.main)
            .sink(receiveValue: stateValueHandler)
            .store(in: &bindings)
    }
}
