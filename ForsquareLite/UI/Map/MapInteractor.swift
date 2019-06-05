//
//  MapInteractor.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 05/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

protocol MapInteractor {
    var observer: MapInteractorObserver? { get set }
    
    func updateMapRegion(center: MapCoordinate, radius: Double)
    func openDetailsForVenue(id: String)
}

protocol MapInteractorObserver: class {
    func interactor(_ intercator: MapInteractorImpl, didUpdateState state: MapInteractorState)
}
