//
//  RestaurantDetailsInteractorImpl.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 05/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

class RestaurantDetailsInteractorImpl: NSObject, RestaurantDetailsInteractor {
    
    var api: NetworkingService
    var observer: RestaurantDetailsInteractorObserver?
    var router: RestaurantDetailsRouter
    var repository: RestaurantDetailsRepository
    
    init(api: NetworkingService, repository: RestaurantDetailsRepository, router: RestaurantDetailsRouter) {
        self.router = router
        self.repository = repository
        self.api = api
        super.init()
        
        self.repository.observer = self
    }
    
    func openWebsite() {
        
        guard let url = self.repository.venueDetails?.url else {
            return
        }
        self.router.openURL(url)
    }
    
    func loadDetails() {
        
        self.updateRestaurantDetails()
        
        let request = DetailsRequest(venueID: self.repository.venue.id)
        self.api.executeRequest(request) { (result, error) in
            
            guard let details = result as? VenueDetails else {
                return
            }
            self.repository.updateVenueDetails(details)
        }
    }
    
    func updateRestaurantDetails() {
        let state = RestaurantDetailsInteractorState(venue: repository.venue,
                                                     venueDetails: repository.venueDetails)
        self.observer?.interactor(self, didUpdateState: state)
    }
}

extension RestaurantDetailsInteractorImpl: RestaurantDetailsRepositoryObserver {
    func repository(_ repository: RestaurantDetailsRepository, didUpdateDetails: VenueDetails?) {
        self.updateRestaurantDetails()
    }
}

