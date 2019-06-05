//
//  VenuesRepository.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 05/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

class VenuesRepository: NSObject {
    
    private var venuesMap = [String: Venue]()

    var venues: [Venue] {
        return Array(venuesMap.values)
    }
    
    func venueFor(id: String) -> Venue? {
        return self.venuesMap[id]
    }
    
    func storeVenues(_ venues:[Venue]) {
        var venuesMap = [String: Venue]()
        for venue in venues {
            venuesMap[venue.id] = venue
        }
        self.venuesMap = venuesMap
    }
    
}
