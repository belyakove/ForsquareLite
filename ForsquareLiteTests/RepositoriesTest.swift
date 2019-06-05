//
//  RepositoriesTest.swift
//  ForsquareLiteTests
//
//  Created by Eugene Belyakov on 06/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import XCTest
@testable import ForsquareLite

class RepositoriesTest: XCTestCase {

    func testVenuesRepository() {
        
        let repository = VenuesRepository()
        
        let venues = [
            Venue(id: "id1", name: "1", coordinate: MapCoordinate.zero),
            Venue(id: "id2", name: "2", coordinate: MapCoordinate.zero)
        ]
        
        repository.storeVenues(venues)
        
        XCTAssertTrue(repository.venues.count == 2)
        XCTAssertEqual(repository.venueFor(id: "id1")?.name, "1")
        XCTAssertEqual(repository.venueFor(id: "id2")?.name, "2")
    }
    
    func testDetailsRepository() {
        
        let venue = Venue(id: "id1", name: "1", coordinate: MapCoordinate.zero)
        
        let repository = RestaurantDetailsRepository(venue: venue)
        XCTAssertNil(repository.venueDetails)

        class MockObserver: RestaurantDetailsRepositoryObserver {
            var called: Bool = false
            func repository(_ repository: RestaurantDetailsRepository, didUpdateDetails: VenueDetails?) {
                called = true
            }
        }
        
        let mockObserver = MockObserver()
        repository.observer = mockObserver
        repository.updateVenueDetails(VenueDetails(rating: nil, url: nil, price: nil, photoURL: nil))
        
        XCTAssertTrue(mockObserver.called)
    }
}
