//
//  MapInteractorImpl.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 05/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

class MapInteractorImpl: NSObject, MapInteractor {
    weak var observer: MapInteractorObserver?
    
    private let repository: VenuesRepository
    private let dataSource: MapDataSource
    private weak var router: MapRouter?
    
    init(dataSource: MapDataSource, repository: VenuesRepository, router: MapRouter) {
        self.dataSource = dataSource
        self.repository = repository
        self.router = router
    }
    
    func updateMapRegion(center: MapCoordinate, radius: Double) {
        self.loadVenues(center: center, radius: radius)
    }
    
    func openDetailsForVenue(id: String) {
        guard let venue = self.repository.venueFor(id: id) else {
            return
        }
        self.router?.openDetailsForVenue(venue)
    }
    
    private func loadVenues(center: MapCoordinate, radius: Double) {
        self.dataSource.venues(atLocation: center, radius: radius) { (venues, error) in
            guard let venues = venues else {
                return
            }
            self.repository.storeVenues(venues)
            self.updateMap()
        }
    }
    
    private func updateMap() {
        let state = MapInteractorState(venues: self.repository.venues)
        self.observer?.interactor(self, didUpdateState: state)
    }
}
