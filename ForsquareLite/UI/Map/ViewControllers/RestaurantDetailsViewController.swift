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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = venue.name
        
        let request = DetailsRequest(venueID: self.venue.id)
        self.api.executeRequest(request) { (result, error) in
            print("result = \(result)")
        }
        
    }
}
