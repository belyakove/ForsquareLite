//
//  ParserTests.swift
//  ForsquareLiteTests
//
//  Created by Eugene Belyakov on 05/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import XCTest
@testable import ForsquareLite

class ParserTests: XCTestCase {

    var mockJson = MockJson()
    
    func testSearchParserValid() {
        let parser = SearchRequestParser()
        let result = parser.parse(jsonObject: self.mockJson.searchObject)
        
        XCTAssertNotNil(result)
        XCTAssert((result as! [Venue]).count == 30)
    }

    func testSearchParserNotValid() {
        let parser = SearchRequestParser()
        let result = parser.parse(jsonObject: self.mockJson.detailsObject)
        
        XCTAssertNil(result)
    }

    func testDetailsParserValid() {
        let parser = DetailsRequestParser()
        let result = parser.parse(jsonObject: self.mockJson.detailsObject)
        
        XCTAssertTrue(result is VenueDetails)
    }

    func testDetailsParserNotValid() {
        let parser = DetailsRequestParser()
        let result = parser.parse(jsonObject: self.mockJson.searchObject)
        
        XCTAssertNil(result)
    }
}
