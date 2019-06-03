//
//  Venue.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 03/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

struct Venue {
    let id: String
    let name: String
    
    let coordinate: MapCoordinate
}

extension Venue: CustomDebugStringConvertible {
    var debugDescription: String {
        return "id: \(id), name: \(name), coordinate: \(coordinate)"
    }
}
