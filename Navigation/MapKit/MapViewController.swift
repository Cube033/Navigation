//
//  MapViewController.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 12.01.2023.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    private lazy var mapView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var myCoordinates = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    private let ddTowerCoordinate = CLLocationCoordinate2D(latitude: 51.2177689, longitude: 6.7614669)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupMap()
    }
    
    
    private func setupView() {
        view.backgroundColor = .white
        setupConstraints()
        requestLocationAuthoriztion()
        addPins()
        addRoute()
    }
    
    private func setupMap() {
        let coordinates = CLLocationCoordinate2D(latitude: 51.2099755, longitude: 6.7434266)
        mapView.setCenter(coordinates, animated: true)
        
        mapView.isRotateEnabled = false
        mapView.showsScale = true
        
        let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 3000, longitudinalMeters: 3000)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.mapView.setRegion(region, animated: true)
        }
    }
    
    private func requestLocationAuthoriztion() {
        let locationManager = CLLocationManager()
        let status = locationManager.authorizationStatus
        locationManager.delegate = self
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            mapView.showsCompass = false
            mapView.showsUserLocation = false
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            mapView.showsCompass = true
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = 100
        @unknown default:
            fatalError("Error")
        }
    }
    
    private func addPins() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = ddTowerCoordinate
        annotation.title = "Düsseldorf tower"
        mapView.addAnnotation(annotation)
    }
    
    private func addRoute() {
        let directionRequest = MKDirections.Request()
        let sourcePlaceMark = MKPlacemark(coordinate: myCoordinates)
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        let destinationPlaceMark = MKPlacemark(coordinate: ddTowerCoordinate)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        directionRequest.transportType = .automobile
        let directions = MKDirections (request: directionRequest)
        directions.calculate { [weak self] response, error in
            guard let self = self else {
                return
            }
            guard let response = response else {
                if let error = error {
                    print(error)
                }
                return
            }
            guard let route = response.routes.first else {
                return
            }
            self.mapView.delegate = self
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
    
    private func setupConstraints() {
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        requestLocationAuthoriztion()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {return}
        let newRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        myCoordinates = location.coordinate
        mapView.setRegion(newRegion, animated: true)
        
    }
}

extension MapViewController: MKMapViewDelegate {
    private func mapView(_ mapView: MKMapView, viewFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 5.0
        renderer.strokeColor = .red
        return renderer
    }
    
}
