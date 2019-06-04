//
//  Utilities.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 04/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit
import MapKit

extension MKMapView {
    var visibleRadius:Double {
        
        let coordinateRect = MapCoordinateRect(coordinateRegion: self.region)
        let topLeft = CLLocation(latitude: coordinateRect.north,
                                 longitude: coordinateRect.west)
        let topRight = CLLocation(latitude: coordinateRect.north,
                                 longitude: coordinateRect.east)
        let bottomRight = CLLocation(latitude: coordinateRect.south,
                                     longitude: coordinateRect.east)
        
        return (topLeft.distance(from: topRight) + topRight.distance(from: bottomRight)) / 4.0
        //return topLeft.distance(from: bottomRight) / 2.0
    }
}
