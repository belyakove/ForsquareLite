//
//  SearchRequestParser.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 03/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

class SearchRequestParser: APIParser {
    
    struct Keys {
        static let response = "response"
        static let venues = "venues"
        static let id = "id"
        static let name = "name"
        static let location = "location"
        static let lat = "lat"
        static let lng = "lng"
    }
    
    func parse(jsonObject: [String : Any]) -> Any? {
        
        guard let responseJsonObject = jsonObject[Keys.response] as? [String: Any] else {
            return nil
        }
        
        guard let venuesJsonObject = responseJsonObject[Keys.venues] as? [[String: Any]] else {
            return nil
        }
        
        var venues = [Venue]()
        
        for venueJsonObject in venuesJsonObject {
            guard let venue = self.parseVenue(jsonObject: venueJsonObject) else {
                continue
            }
            venues.append(venue)
        }
        return venues
    }
    
    func parseVenue(jsonObject: [String: Any]) -> Venue? {
        
        guard let id = jsonObject[Keys.id] as? String else {
            return nil
        }
        
        guard let name = jsonObject[Keys.name] as? String else {
            return nil
        }
        
        guard let locationJsonObject = jsonObject[Keys.location] as? [String: Any] else {
            return nil
        }
        
        guard let location = self.parseLocation(jsonObject: locationJsonObject) else {
            return nil
        }
        
        let venue = Venue(id: id, name: name, coordinate: location)
        
        return venue
    }
    
    func parseLocation(jsonObject: [String: Any]) -> MapCoordinate? {
        
        guard let lat = jsonObject[Keys.lat] as? Double else {
            return nil
        }
        
        guard let lng = jsonObject[Keys.lng] as? Double else {
            return nil
        }
        
        return MapCoordinate(latitude: lat, longitude: lng)
    }
    
}
