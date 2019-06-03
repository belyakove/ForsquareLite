//
//  Environment.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 03/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

enum EnvironmentType: String {
    case staging = "Staging"
    case production = "Production"
}

struct Environment {
    
    struct Keys {
        static let Common = "Common"
        static let BaseURL = "baseURL"
    }
    
    var configuration: [String: Any] = [:]
    
    init(_ environmentType: EnvironmentType) {
        
        guard let configPath = Bundle.main.path(forResource: "Configuration", ofType: "plist") else {
            return
        }
        
        guard let configDictionary = NSDictionary(contentsOfFile: configPath) as? [String: Any] else {
            return
        }
        
        guard let commonConfiguration = configDictionary[Keys.Common] as? [String: Any] else {
            return
        }
                
        self.configuration.merge(commonConfiguration) { (_, last) in last }
        
        guard let specificConfiguration = configDictionary[environmentType.rawValue] as? [String: Any] else {
            return
        }
        
        self.configuration.merge(specificConfiguration) { (_, last) in last }
    }
}

extension Environment {
    var baseURL: URL {
        return URL(string: self.configuration[Keys.BaseURL] as? String ?? "")!
    }
}
