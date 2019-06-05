//
//  MapCoordinateRect+MapKit.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 03/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit
import MapKit

extension MapCoordinateRect {

    init(_ region: MKCoordinateRegion) {
        self.south = region.center.latitude - region.span.latitudeDelta / 2.0
        self.west = region.center.longitude - region.span.longitudeDelta / 2.0
        self.north = region.center.latitude + region.span.latitudeDelta / 2.0
        self.east = region.center.longitude + region.span.longitudeDelta / 2.0
    }
    
}
