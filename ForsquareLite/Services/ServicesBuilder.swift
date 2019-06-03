//
//  ServiceBuilder.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 03/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

class ServicesBuilder: NSObject {

    class func buildServices(environment: Environment) -> Services {
        let networkingService = NetworkingServiceImpl(baseURL: environment.baseURL)
        
        return Services(networkService: networkingService)
    }
    
}
