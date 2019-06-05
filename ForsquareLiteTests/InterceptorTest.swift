//
//  InterceptorTest.swift
//  ForsquareLiteTests
//
//  Created by Eugene Belyakov on 06/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import XCTest
@testable import ForsquareLite

class InterceptorTest: XCTestCase {

    func testAuthInterceptor() {
        let credentials = Credentials(clientID: "username", clientSecret: "password")
        let interceptor = FoursquareAuthenticationInterceptor(authenticationInfo: credentials)
        
        let request = BasicAPIRequest()
        
        XCTAssertNil(request.queryParameters?["client_id"])
        XCTAssertNil(request.queryParameters?["client_secret"])
        
        interceptor.preporcessRequest(request)
        
        XCTAssertEqual(request.queryParameters?["client_id"], "username")
        XCTAssertEqual(request.queryParameters?["client_secret"], "password")
    }
    
}
