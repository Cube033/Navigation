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
    
    //MARK: - Variables
    
    private lazy var mapsView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var myCoordinates: CLLocationCoordinate2D {
        guard let coordinate = locationManager.location?.coordinate else {
            return CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
        return coordinate
    }
    
    let locationManager = CLLocationManager()
    
    lazy var routeButton = CustomButton(title: "Проложить маршрут", backgroundColor: nil, tapAction: {
        self.addRouteOverLay()
    })
    
    let tapAnnotation = MKPointAnnotation()
    
    //MARK: - Lyfe cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupMap()
    }
    
    //MARK: - functions
    
    private func addRouteOverLay(){
        self.mapsView.removeOverlays(mapsView.overlays)
        
        let startpoint = MKPlacemark(coordinate: myCoordinates)
        let endpoint = MKPlacemark(coordinate: tapAnnotation.coordinate)
        let request = MKDirections.Request ()
        request.source = MKMapItem(placemark: startpoint)
        request.destination = MKMapItem (placemark: endpoint)
        request.transportType = .automobile
        let direction = MKDirections (request: request)
        direction.calculate { (response, error) in
            guard let response = response else { return }
            for route in response.routes {
                self.addOverLayOnMap(route: route)
                break
            }
        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        mapsView.delegate = self
        locationManager.delegate = self
        
        setupConstraints()
        requestLocationAuthoriztion()
    }
    
    private func setupMap() {
        let coordinates = CLLocationCoordinate2D(latitude: 51.2099755, longitude: 6.7434266)
        mapsView.setCenter(coordinates, animated: true)
        mapsView.isRotateEnabled = false
        mapsView.showsScale = true
        
        let region = MKCoordinateRegion(center: myCoordinates, latitudinalMeters: 3000, longitudinalMeters: 3000)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.mapsView.setRegion(region, animated: true)
        }
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer()
        longPressGestureRecognizer.minimumPressDuration = 0.5
        longPressGestureRecognizer.addTarget(self, action: #selector(handleLongPress(gestureRecognizer:)))
        mapsView.addGestureRecognizer(longPressGestureRecognizer)
        routeButton.isHidden = true
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        
        mapsView.removeAnnotations(mapsView.annotations)
        if gestureRecognizer.state == .ended {
            let touchLocation = gestureRecognizer.location(in: mapsView)
            let coordinate = mapsView.convert(touchLocation, toCoordinateFrom: mapsView)
            tapAnnotation.coordinate = coordinate
            mapsView.addAnnotation(tapAnnotation)
            routeButton.isHidden = false
        }
    }
    
    private func requestLocationAuthoriztion() {
        let status = locationManager.authorizationStatus
        
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            mapsView.showsCompass = false
            mapsView.showsUserLocation = false
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            mapsView.showsCompass = true
            mapsView.showsUserLocation = true
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = 10
        @unknown default:
            fatalError("Error")
        }
    }
    
    //MARK: - Constraints
    
    private func setupConstraints() {
        view.addSubview(mapsView)
        view.addSubview(routeButton)
        
        NSLayoutConstraint.activate([
            mapsView.topAnchor.constraint(equalTo: view.topAnchor),
            mapsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            routeButton.heightAnchor.constraint(equalToConstant: 40),
            routeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            routeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            routeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110),
        ])
    }
}

//MARK: - Extensions

extension MapViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        requestLocationAuthoriztion()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {return}
        let newRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        mapsView.setRegion(newRegion, animated: true)
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var viewMarker: MKMarkerAnnotationView
        let idView = "marker"
        if let view = mapView.dequeueReusableAnnotationView(withIdentifier: idView) as? MKMarkerAnnotationView{
            view.annotation = annotation
            viewMarker = view
        } else {
            viewMarker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: idView)
            viewMarker.canShowCallout = true
            viewMarker.calloutOffset = CGPoint(x: 0, y: 6)
            viewMarker.rightCalloutAccessoryView = UIImageView(image: UIImage(systemName: "shift.fill"))
        }
        return viewMarker
    }
    
    func addOverLayOnMap(route: MKRoute) {
        mapsView.addOverlay (route.polyline)
        let rect = route.polyline.boundingMapRect
        mapsView.setRegion(MKCoordinateRegion(rect), animated: true)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .blue
        renderer.lineWidth = 4
        return renderer
    }
}
