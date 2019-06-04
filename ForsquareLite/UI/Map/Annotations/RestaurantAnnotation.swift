//
//  RestaurantAnnotation.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 04/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit
import MapKit

class RestaurantAnnotation: NSObject, MKAnnotation {
    
    static let ReuseID = "Restaurant"
    
    let venue: Venue
    var coordinate: CLLocationCoordinate2D {
        return venue.coordinate.coreLocationCoordinate
    }
    
    var title: String? {
        return venue.name
    }
    
    init(venue: Venue) {
        self.venue = venue
    }

    override var hash: Int {
        return venue.id.hash
    }
    
    public static func == (lhs: RestaurantAnnotation, rhs: RestaurantAnnotation) -> Bool {
        return lhs.venue.id == rhs.venue.id
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        return self.venue.id == (object as? RestaurantAnnotation)?.venue.id
    }

}
