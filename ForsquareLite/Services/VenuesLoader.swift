//
//  VenuesLoader.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 03/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

class VenuesLoader: NSObject, MapDataSource {
    
    let api: NetworkingService
    
    init(api: NetworkingService) {
        self.api = api
    }
    
    func venues(inRect rect: MapCoordinateRect, completionBlock: @escaping ([Venue]?, Error?) -> Void) -> Cancellable? {
        
        let request = SearchRequest(coordinateRect: rect)
        
        return self.api.executeRequest(request) { (result, error) in
            
            guard error == nil else {
                completionBlock(nil, error)
                return
            }
            
            guard let venues = result as? [Venue] else {
                completionBlock(nil, URLError(.badServerResponse))
                return
            }
            
            completionBlock(venues, nil)
        }
    }
}
