//
//  DetailsRequest.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 04/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

class DetailsRequest: BasicAPIRequest {

    let venueID: String
    let requestParser = DetailsRequestParser()
    
    init(venueID: String) {
        self.venueID = venueID
    }
    
    override var parser: APIParser {
        return requestParser
    }
    
    override var path: String {
        return "/v2/venues/\(venueID)"
    }
    
    override var defaultQueryParameters: [String : String]? {
        return ["v" : "20190603"]
    }
    
}
