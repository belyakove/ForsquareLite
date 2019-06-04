//
//  MapViewControllerRouter.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 04/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

protocol MapViewControllerRouter: class {
    func openDetailsForVenue(_ venue: Venue) -> Void
}
