//
//  RestaurantDetailsPresenterImpl.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 05/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

class RestaurantDetailsPresenterImpl: NSObject, RestaurantDetailsPresenter {

    var interactor: RestaurantDetailsInteractor
    var view: RestaurantDetailsView?

    init(interactor: RestaurantDetailsInteractor) {
        self.interactor = interactor
        super.init()
        self.interactor.observer = self
    }

    func viewWillAppear(_ view: RestaurantDetailsView) {
        self.interactor.loadDetails()
    }
    
    func viewDidRequestToOpenWebsite(_ view: RestaurantDetailsView) {
        self.interactor.openWebsite()
    }
}

extension RestaurantDetailsPresenterImpl: RestaurantDetailsInteractorObserver {
    func interactor(_ intercator: RestaurantDetailsInteractor, didUpdateState state: RestaurantDetailsInteractorState) {
        
        let venue = state.venue
        let venueDetails = state.venueDetails
        
        var price: PriceViewModel?
        if let priceDetail = venueDetails?.price {
            var tagString: String = String()
            
            for _ in 0..<priceDetail.tier {
                tagString.append(contentsOf: priceDetail.currency)
            }
            price = PriceViewModel(pricing: tagString, message: priceDetail.message)
        }
        
        var rating: RatingViewModel?
        if let ratingDetail = venueDetails?.rating {
            
            var color: UIColor?
            if let ratingColor = ratingDetail.ratingColor {
                 color = UIColor(hexString: ratingColor)
            }
            
            rating = RatingViewModel(rating: ratingDetail.rating,
                                     ratingColor: color)
        }
        
        let websiteAvailable = venueDetails?.url != nil
        
        
        self.view?.viewModel = RestaurantDetailsViewModel(name: venue.name,
                                   websiteAvailable: websiteAvailable,
                                   price: price,
                                   rating: rating,
                                   photoURL: venueDetails?.photoURL)
    }
}

