//
//  BasicAPIRequest.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 03/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

extension APIRequest {
    
    var path: String {
        return ""
    }
    
    var method: APIRequestMethod {
        return .GET
    }
    
    var queryParameters: [String : String]? {
        return nil
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    var headers: [String : String]? {
        return nil
    }
}
