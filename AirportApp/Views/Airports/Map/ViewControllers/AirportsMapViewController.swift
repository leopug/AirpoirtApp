//
//  AirpoirtMapViewController.swift
//  AirpoirtApp
//
//  Created by Leonardo Maia Pugliese on 29/04/21.
//

import UIKit
import Combine

final class AirportsMapViewController: UIViewController {

    private var viewModel: AirportsMapBaseViewModel!
    private var contentView: AirportMapView!
    private var bindings = Set<AnyCancellable>()
    private var airportPassthroughSubject = PassthroughSubject<(Airport), Never>()
    
    init(viewModel: AirportsMapBaseViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        title = ContextStrings.Airport.Map.navigationAirportsMapTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        contentView = AirportMapView(airportPassthroughSubject: airportPassthroughSubject)
        view = contentView
        
        configureViewModelBindings()
    }

    private func configureViewModelBindings() {
        configureStateBinding()
        configureAirportAnnotationListBinding()
        configureAirportPassthroughSubject()
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
            .getAirportsMapViewModelStatePublisher()
            .receive(on: RunLoop.main)
            .sink(receiveValue: stateValueHandler)
            .store(in: &bindings)
    }
    
    private func configureAirportPassthroughSubject() {
        airportPassthroughSubject.sink { [weak self] airport in
            self?.viewModel.getAirportPassthroughSubject().send(airport)
        }.store(in: &bindings)
    }
    
    private func configureAirportAnnotationListBinding() {
        let airportAnnotationListHandler: ([AirportAnnotation]) -> Void = {[weak self] airportAnnotationList in
            self?.contentView.setAnnotations(annotations: airportAnnotationList)
        }
        
        viewModel
            .getAnnotationPublisher()
            .sink(receiveValue: airportAnnotationListHandler)
            .store(in: &bindings)
    }
}
