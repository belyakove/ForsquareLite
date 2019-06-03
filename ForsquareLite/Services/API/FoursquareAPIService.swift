//
//  FoursquareAPIService.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 03/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

class FoursquareAPIService: NSObject, NetworkingService {

    let internalNetworkingService: NetworkingService
    let authenticationInfo: AuthenticationInfo
    
    let requestInterceptors: [APIRequestInterceptor]
    
    init(apiService: NetworkingService, authenticatoinInfo: AuthenticationInfo) {
        self.internalNetworkingService = apiService
        self.authenticationInfo = authenticatoinInfo
        
        let authInterceptor = FoursquareAuthenticationInterceptor(authenticationInfo: authenticatoinInfo)
        self.requestInterceptors = [authInterceptor]
    }
    
    func executeRequest(_ request: APIRequest, completionBlock: NetworkRequestCompletionBlock?) -> Cancellable? {
        
        self.preprocess(request: request)
        
        return self.internalNetworkingService.executeRequest(request, completionBlock: completionBlock)
    }
    
    private func preprocess(request: APIRequest) {
        for interceptor in self.requestInterceptors {
            interceptor.preporcessRequest(request)
        }
    }
    
}
