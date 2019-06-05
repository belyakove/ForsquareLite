//
//  MapInteractorTest.swift
//  ForsquareLiteTests
//
//  Created by Eugene Belyakov on 06/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import XCTest
@testable import ForsquareLite

class MapInteractorTest: XCTestCase {

    class DataSourceMock: MapDataSource {
        let venues = [
            Venue(id: "1", name: "", coordinate: MapCoordinate.zero),
            Venue(id: "2", name: "", coordinate: MapCoordinate.zero)
        ]

        @discardableResult func venues(inRect rect: MapCoordinateRect,
                                       completionBlock: @escaping MapDataSourceCompletionBlock) -> Cancellable? {
            completionBlock(venues, nil)
            return nil
        }
        @discardableResult func venues(atLocation location: MapCoordinate,
                                       radius: Double,
                                       completionBlock: @escaping MapDataSourceCompletionBlock) -> Cancellable? {
            completionBlock(venues, nil)
            return nil
        }
    }
    
    class RouterMock: MapRouter {
        var called: Int = 0
        func openDetailsForVenue(_ venue: Venue) {
            called += 1
        }
    }

    func testDataLoading() {
        
        class MockObserver: MapInteractorObserver {
            var called: Int = 0
            func interactor(_ intercator: MapInteractor, didUpdateState state: MapInteractorState) {
                called += 1
            }
        }
        
        let interactor = MapInteractorImpl(dataSource: DataSourceMock(),
                                           repository: VenuesRepository(),
                                           router: RouterMock())
        let mockObserver = MockObserver()
        interactor.observer = mockObserver
        
        XCTAssertEqual(mockObserver.called, 0)
        
        interactor.updateMapRegion(center: MapCoordinate.zero, radius: 0)
        
        XCTAssertEqual(mockObserver.called, 1)
    }
    
    func testOpeningDetails() {
        let router = RouterMock()
        let interactor = MapInteractorImpl(dataSource: DataSourceMock(),
                                           repository: VenuesRepository(),
                                           router: router)
        interactor.updateMapRegion(center: MapCoordinate.zero, radius: 0)
        
        interactor.openDetailsForVenue(id: "invalid")
        
        XCTAssertEqual(router.called, 0)
        
        interactor.openDetailsForVenue(id: "1")
        
        XCTAssertEqual(router.called, 1)
    }
    
}
