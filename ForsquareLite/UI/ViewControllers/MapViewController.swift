//
//  MasterViewController.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 03/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    private var userTrackingButton: MKUserTrackingButton!
    private var scaleView: MKScaleView!
    
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.showsUserLocation = true
        self.setupUserTrackingButtonAndScaleView()
        
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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

}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        let locationAuthorized = status == .authorizedWhenInUse
        self.userTrackingButton.isHidden = !locationAuthorized
    }
}
