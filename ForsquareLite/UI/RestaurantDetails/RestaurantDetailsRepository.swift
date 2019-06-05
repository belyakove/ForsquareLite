//
//  RestaurantDetailsRepository.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 05/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

class RestaurantDetailsRepository: NSObject {
    
    weak var observer: RestaurantDetailsRepositoryObserver?
    
    let venue: Venue
    var venueDetails: VenueDetails?
    
    init(venue: Venue) {
        self.venue = venue
    }

    func updateVenueDetails(_ venueDetails: VenueDetails?) {
        self.venueDetails = venueDetails
        self.observer?.repository(self, didUpdateDetails: self.venueDetails)
    }
}

protocol RestaurantDetailsRepositoryObserver: class {
    func repository(_ repository: RestaurantDetailsRepository, didUpdateDetails: VenueDetails?)
}


