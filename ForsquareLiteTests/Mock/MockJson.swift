//
//  MockJson.swift
//  ForsquareLiteTests
//
//  Created by Eugene Belyakov on 06/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

class MockJson: NSObject {
    var searchObject: [String: Any]
    var detailsObject: [String: Any]
    
    override init() {
        
        let bundle = Bundle(for: MockJson.self)
        
        let searchPath = bundle.path(forResource: "search", ofType: "json")!
        let searchJsonData = try! Data(contentsOf: URL(fileURLWithPath: searchPath))
        self.searchObject = try! JSONSerialization.jsonObject(with: searchJsonData, options: []) as! [String: Any]
        
        let detailsPath = bundle.path(forResource: "details", ofType: "json")!
        let detailsJsonData = try! Data(contentsOf: URL(fileURLWithPath: detailsPath))
        self.detailsObject = try! JSONSerialization.jsonObject(with: detailsJsonData, options: []) as! [String: Any]
        
    }
}
