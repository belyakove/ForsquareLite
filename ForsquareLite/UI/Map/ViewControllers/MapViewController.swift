//
//  MasterViewController.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 03/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit
import MapKit
import AlamofireImage

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    private var userTrackingButton: MKUserTrackingButton!
    private var scaleView: MKScaleView!
    
    private let locationManager = CLLocationManager()

    var mapDataSource: MapDataSource!
    
    var loadWorkItem: DispatchWorkItem?
    
    var currentAnnotations = Set<RestaurantAnnotation>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.showsUserLocation = true
        self.mapView.setUserTrackingMode(.follow, animated: true)
        self.setupUserTrackingButtonAndScaleView()
        
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        self.mapView.register(MKMarkerAnnotationView.self,
                              forAnnotationViewWithReuseIdentifier: RestaurantAnnotation.ReuseID)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadVenues(center: self.mapView.region.center, radius: self.mapView.visibleRadius)
    }

    private func setupUserTrackingButtonAndScaleView() {
        self.mapView.showsUserLocation = true
        self.mapView.showsCompass = false
        
        self.userTrackingButton = MKUserTrackingButton(mapView: mapView)
        self.userTrackingButton.isHidden = true
        view.addSubview(userTrackingButton)
        
        self.scaleView = MKScaleView(mapView: mapView)
        self.scaleView.legendAlignment = .trailing
        view.addSubview(scaleView)
        
        let stackView = UIStackView(arrangedSubviews: [scaleView, userTrackingButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
                                     stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)])
        
        let compassView = MKCompassButton(mapView: self.mapView)
        compassView.translatesAutoresizingMaskIntoConstraints = false
        compassView.compassVisibility = .adaptive
        view.addSubview(compassView)
        
        NSLayoutConstraint.activate([compassView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50), compassView.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)])
        
    }
    
    private func loadVenues(inRegion region: MKCoordinateRegion) {
        
        let rect = MapCoordinateRect(coordinateRegion: region)
        self.mapDataSource.venues(inRect: rect, completionBlock: { (venues, error) in
            guard let venues = venues else {
                return
            }
            self.updateAnnotationsForVenues(venues)
        })
    }
    
    private func loadVenues(center: CLLocationCoordinate2D, radius: Double) {
        
        let coordinate = MapCoordinate(coordinate: center)
        self.mapDataSource.venues(atLocation: coordinate, radius: radius) { (venues, error) in
            guard let venues = venues else {
                return
            }
            self.updateAnnotationsForVenues(venues)
        }
    }
    
    private func updateAnnotationsForVenues(_ venues: [Venue]) {
        
        var annotations = Set<RestaurantAnnotation>()
        for venue in venues {
            let annotation = RestaurantAnnotation(venue: venue)
            annotations.insert(annotation)
        }
        
        let before = self.currentAnnotations
        let after = annotations
        
        let toKeep = before.intersection(after)
        let toAdd = after.subtracting(toKeep)
        let toRemove = before.subtracting(after)
        
        self.currentAnnotations = toKeep.union(toAdd)
        
        self.mapView.addAnnotations(Array(toAdd))
        self.mapView.removeAnnotations(Array(toRemove))
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        let locationAuthorized = status == .authorizedWhenInUse
        self.userTrackingButton.isHidden = !locationAuthorized
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: RestaurantAnnotation.ReuseID)
        annotationView?.canShowCallout = true
        annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        
        return annotationView
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        if let workItem = self.loadWorkItem {
            workItem.cancel()
            self.loadWorkItem = nil
        }
        
        let loadWorkItem = DispatchWorkItem(block: { [weak self] in
            
            guard let strongSelf = self else {
                return
            }
            
            let coordinate: CLLocationCoordinate2D
            if mapView.userTrackingMode == .follow {
                coordinate = mapView.userLocation.coordinate
            } else {
                coordinate = mapView.region.center
            }
            
            strongSelf.loadVenues(center: coordinate, radius: mapView.visibleRadius)
        })
        
        self.loadWorkItem = loadWorkItem
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: loadWorkItem)
    }
}
