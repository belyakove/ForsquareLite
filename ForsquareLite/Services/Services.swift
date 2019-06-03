//
//  Services.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 03/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

class Services: NSObject {
    
    var networkingService: NetworkingService
    
    init(networkService: NetworkingService) {
        
        self.networkingService = networkService
        
        super.init()
    }
}
