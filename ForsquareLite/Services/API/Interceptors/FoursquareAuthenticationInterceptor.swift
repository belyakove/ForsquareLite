//
//  FoursquareAuthenticationInterceptor.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 03/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

class FoursquareAuthenticationInterceptor: APIRequestInterceptor {
    
    let authenticationInfo: AuthenticationInfo
    
    init(authenticationInfo: AuthenticationInfo) {
        self.authenticationInfo = authenticationInfo
    }
    
    func shouldPreprocessRequest(_ request: APIRequest) -> Bool {
        return true
    }
    
    func preporcessRequest(_ request: APIRequest) {
        request.addQueryParameter(key: "client_id", value: self.authenticationInfo.clientID)
        request.addQueryParameter(key: "client_secret", value: self.authenticationInfo.clientSecret)
    }

}
