//
//  AirtportMapView.swift
//  AirpoirtApp
//
//  Created by Leonardo Maia Pugliese on 29/04/21.
//

import UIKit
import MapKit
import Combine

final class AirportMapView: UIView {
    
    private var activityIndicationView: ActivityIndicatorView!
    private var mapView: MKMapView!
    private var annotations: [AirportAnnotation]?
    private var airportPassthroughSubject: PassthroughSubject<(Airport), Never>?

    init(airportPassthroughSubject: PassthroughSubject<(Airport), Never>) {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        self.airportPassthroughSubject = airportPassthroughSubject
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        configureMapView()
        configureActivityIndicatorView()
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

    private func configureMapView() {
        mapView = MKMapView()
        addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        mapView.delegate = self
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    func setAnnotations(annotations: [AirportAnnotation]) {
        self.annotations = annotations
        
        for annotation in annotations {
            mapView.addAnnotation(annotation)
        }
    }
    
    func startLoading() {
        activityIndicationView.isHidden = false
        activityIndicationView.startAnimating()
    }
    
    func finishLoading() {
        activityIndicationView.stopAnimating()
    }
    
}

extension AirportMapView: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        guard let annotation = view.annotation as? AirportAnnotation else { return }
        airportPassthroughSubject?.send(annotation.airport)
    }
    
}
