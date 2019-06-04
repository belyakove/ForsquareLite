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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = venue.name
    }
}
