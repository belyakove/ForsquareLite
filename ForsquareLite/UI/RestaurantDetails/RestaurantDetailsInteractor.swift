//
//  RestaurantDetailsInteractor.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 05/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

protocol RestaurantDetailsInteractor {
    var observer: RestaurantDetailsInteractorObserver? { get set }
    
    func openWebsite()
    func loadDetails()
}

protocol RestaurantDetailsInteractorObserver: class {
    func interactor(_ intercator: RestaurantDetailsInteractor,
                    didUpdateState state: RestaurantDetailsInteractorState)
}
