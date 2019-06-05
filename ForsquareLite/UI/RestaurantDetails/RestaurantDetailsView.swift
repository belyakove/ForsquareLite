//
//  RestaurantDetailsView.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 05/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

protocol RestaurantDetailsView: class {
    var viewModel: RestaurantDetailsViewModel? { get set }
}
