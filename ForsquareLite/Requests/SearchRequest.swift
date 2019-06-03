//
//  SearchRequest.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 03/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

class SearchRequest: BasicAPIRequest {
    
    private var coordinateRect: MapCoordinateRect
    
    init(coordinateRect: MapCoordinateRect) {
        self.coordinateRect = coordinateRect
        super.init()
        self.parser = SearchRequestParser()
    }
    
    override var path: String {
        return "/v2/venues/search"
    }

    override var defaultQueryParameters: [String : String]? {
        
        var parameters = [String: String]()
        
        parameters["ne"] = "\(coordinateRect.north),\(coordinateRect.east)"
        parameters["sw"] = "\(coordinateRect.south),\(coordinateRect.west)"
        parameters["intent"] = "browse"
        parameters["v"] = "20190603"
        
        return parameters
    }
    
}
