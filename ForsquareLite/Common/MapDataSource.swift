//
//  MapDataSource.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 03/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

typealias MapDataSourceCompletionBlock = ([Venue]?, Error?) ->Void

protocol MapDataSource {
    @discardableResult func venues(inRect rect: MapCoordinateRect,
                                   completionBlock: @escaping MapDataSourceCompletionBlock) -> Cancellable?
}
