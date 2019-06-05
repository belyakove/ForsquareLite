//
//  RestaurantDetailsViewController.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 04/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

class RestaurantDetailsViewController: UIViewController, RestaurantDetailsView {
    
    var presenter: RestaurantDetailsPresenter?

    var viewModel: RestaurantDetailsViewModel? {
        didSet {
            self.updateView()
        }
    }
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.presenter?.viewWillAppear(self)
    }
    
    func updateView() {
        self.navigationItem.title = viewModel?.name
        self.showDetails(viewModel)
    }
    
    func showDetails(_ details: RestaurantDetailsViewModel?) {
    
        var views = [UIView]()
        
        if let photoURL = details?.photoURL {
            views.append(PhotoView.withPhotoURL(photoURL))
        }

        if let rating = details?.rating {
            views.append(RatingView.withRating(rating))
        }
        
        if let price = details?.price {
            views.append(PriceView.withPrice(price))
        }
        
        if details?.websiteAvailable == true {
            let websiteView = WebsiteView.with(delegate: self)
            views.append(websiteView)
        }
        
        self.displayViews(views)
    }
    
    func displayViews(_ views: [UIView]) {
        let existingSubviews = self.stackView.arrangedSubviews
        for subview in existingSubviews {
            self.stackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        for view in views {
            self.stackView.addArrangedSubview(view)
        }
    }
}

extension RestaurantDetailsViewController: WebsiteViewDelegate {
    func websiteViewDidRequestOpenURL(_ view: UIView) {
        self.presenter?.viewDidRequestToOpenWebsite(self)
    }
}
