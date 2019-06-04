//
//  DetailsRequestParser.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 04/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

class DetailsRequestParser: APIParser {
    
    struct Keys {
        static let response = "response"
        static let venue = "venue"
        static let price = "price"
        static let photos = "photos"
        static let tier = "tier"
        static let currency = "currency"
        static let message = "message"
        static let url = "canonicalUrl"
        static let rating = "rating"
        static let ratingColor = "ratingColor"
    }

    func parse(jsonObject: [String : Any]) -> Any? {
        guard let responseJsonObject = jsonObject[Keys.response] as? [String: Any] else {
            return nil
        }
        
        guard let venueJsonObject = responseJsonObject[Keys.venue] as? [String: Any] else {
            return nil
        }

        var price: Price?
        if let priceJsonObject = venueJsonObject[Keys.price] as? [String: Any] {
            price = self.parsePrice(jsonObject: priceJsonObject)
        }
        
        var url: URL?
        if let urlString = venueJsonObject[Keys.url] as? String {
            url = URL(string: urlString)
        }
        
        let rating = self.parseRating(jsonObject: venueJsonObject)
        
        return VenueDetails(rating: rating,
                            url: url,
                            price: price)
    }
    
    func parsePrice(jsonObject: [String: Any]) -> Price? {
        
        guard let tier = jsonObject[Keys.tier] as? Int else {
            return nil
        }
        
        guard let currency = jsonObject[Keys.currency] as? String else {
            return nil
        }
        
        guard let message = jsonObject[Keys.message] as? String else {
            return nil
        }

        return Price(tier: tier, currency: currency, message: message)
    }
    
    func parseRating(jsonObject: [String: Any]) -> Rating? {
        guard let rating = jsonObject[Keys.rating] as? Double else {
            return nil
        }
        
        var color: UIColor?
        if let ratingColorString = jsonObject[Keys.ratingColor] as? String {
            color = UIColor(hexString: ratingColorString)
        }
        
        return Rating(rating: String(format: "%.1f", rating), ratingColor: color)
    }
}
