//
//  MapPresenterImpl.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 05/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

class MapPresenterImpl: NSObject, MapPresenter {

    weak var view: MapView?
    var interactor: MapInteractor
    
    init(interactor: MapInteractor) {
        self.interactor = interactor
        super.init()
        self.interactor.observer = self
    }
        
    func mapView(_ view: MapView, didUpdateCenter center: MapCoordinate, radius: Double) {
        self.interactor.updateMapRegion(center: center, radius: radius)
    }
    
    func mapView(_ view: MapView, didRequestOpenDetailsForVenueWithID id: String) {
        self.interactor.openDetailsForVenue(id: id)
    }
}

extension MapPresenterImpl: MapInteractorObserver {
    
    func interactor(_ intercator: MapInteractor, didUpdateState state: MapInteractorState) {
        
        let venueViewModels = state.venues.map { (venue) -> VenueViewModel in
            return VenueViewModel(id: venue.id,
                                  name:venue.name,
                                  coordinate: venue.coordinate)
        }
        self.view?.viewModel = MapViewModel(venuesModels: venueViewModels)
    }
}
