//
//  SearchRequest.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 03/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

class SearchRequest: BasicAPIRequest {
    
    private var coordinateRect: MapCoordinateRect?
    private var center: MapCoordinate?
    private var radius: Double?
    
    private var responseParser = SearchRequestParser()
    
    override internal var parser: APIParser {
        return responseParser
    }
    
    private override init() {}
    
    init(coordinateRect: MapCoordinateRect) {
        self.coordinateRect = coordinateRect
        super.init()
    }
    
    init(center: MapCoordinate, radius: Double) {
        self.center = center
        self.radius = min(radius, 1000000)
        super.init()
    }
    
    override var path: String {
        return "/v2/venues/search"
    }

    override var defaultQueryParameters: [String : String]? {
        
        var parameters = [String: String]()
        
        if let coordinateRect = self.coordinateRect {
            parameters["ne"] = "\(coordinateRect.north),\(coordinateRect.east)"
            parameters["sw"] = "\(coordinateRect.south),\(coordinateRect.west)"
        } else if let center = self.center, let radius = self.radius {
            parameters["ll"] = "\(center.latitude),\(center.longitude)"
            parameters["radius"] = "\(radius)"
        }
        
        parameters["intent"] = "browse"
        parameters["v"] = "20190603"
        parameters["query"] = "restaurant"
        parameters["limit"] = "50"
        
        return parameters
    }
    
}
