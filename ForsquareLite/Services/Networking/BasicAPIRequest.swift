//
//  BasicAPIRequest.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 03/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

class BasicAPIRequest: APIRequest {

    var parser: APIParser {
        return DefaultAPIParser()
    }
    
    private var additionalParameters: [String: String] = [String: String]()
    
    var path: String {
        return ""
    }
    
    var method: APIRequestMethod {
        return .GET
    }
    
    var queryParameters: [String : String]? {
        
        guard self.defaultQueryParameters != nil || !additionalParameters.isEmpty else {
                return nil
        }
        
        var queryParameters = [String : String]()
        
        if let defaultParameters = self.defaultQueryParameters {
           queryParameters.merge(defaultParameters) { (_, last) in last }
        }

        queryParameters.merge(additionalParameters) { (_, last) -> String in last }
        
        return queryParameters
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var defaultQueryParameters: [String : String]? {
        return nil
    }
    
    func addQueryParameter(key: String, value: String) {
        self.additionalParameters[key] = value
    }
    
}
