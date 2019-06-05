//
//  RestaurantDetailsViewModel.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 05/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

struct RestaurantDetailsViewModel {
    let name: String
    let websiteAvailable: Bool
    let price: PriceViewModel?
    let rating: RatingViewModel?
    let photoURL: URL?
}
