//
//  RestaurantDetailsPresenter.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 05/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

protocol RestaurantDetailsPresenter {
    var view: RestaurantDetailsView? { get set }
    
    func viewWillAppear(_ view: RestaurantDetailsView)
    func viewDidRequestToOpenWebsite(_ view: RestaurantDetailsView)
}
