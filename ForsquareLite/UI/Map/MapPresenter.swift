//
//  MapViewPresenter.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 05/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

protocol MapPresenter {
    var view: MapView? { get set }
    func mapView(_ view: MapView, didUpdateCenter: MapCoordinate, radius: Double)
    func mapView(_ view: MapView, didRequestOpenDetailsForVenueWithID id: String)
}
