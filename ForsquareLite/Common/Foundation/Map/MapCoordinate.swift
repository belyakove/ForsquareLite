//
//  MapCoordinate.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 03/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

struct MapCoordinate {
    let latitude: Double
    let longitude: Double
}

extension MapCoordinate: CustomDebugStringConvertible {
    var debugDescription: String {
        return "lat = \(self.latitude), lon = \(self.longitude)"
    }
}
