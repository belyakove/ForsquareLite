//
//  RestaurantDetailsViewController.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 04/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

class RestaurantDetailsViewController: UIViewController {

    var venue: Venue!
    var api: NetworkingService!
    weak var router: RestaurantDetailsRouter?
    
    @IBOutlet weak var stackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = venue.name
        
        let request = DetailsRequest(venueID: self.venue.id)
        self.api.executeRequest(request) { (result, error) in
           
            guard let details = result as? VenueDetails else {
                return
            }
            
            self.details = details
        }
        
    }
    
    var details: VenueDetails? {
        didSet {
            self.showDetails(self.details)
        }
    }
    
    func showDetails(_ details: VenueDetails?) {
    
        var views = [UIView]()
        
        if let rating = details?.rating {
            views.append(RatingView.withRating(rating))
        }
        
        if let price = details?.price {
            views.append(PriceView.withPrice(price))
        }
        
        if let url = details?.url {
            let websiteView = WebsiteView.withURL(url, delegate: self)
            views.append(websiteView)
        }
        
        self.displayViews(views)
    }
    
    func displayViews(_ views: [UIView]) {
        for view in views {
            self.stackView.addArrangedSubview(view)
        }
    }
    
}


extension RestaurantDetailsViewController: WebsiteViewDelegate {
    func websiteView(_ view: UIView, didRequestOpenURL url: URL) {
        self.router?.openURL(url)
    }
}
