//
//  MainFlowCoordinator.swift
//  ForsquareLite
//
//  Created by Eugene Belyakov on 04/06/2019.
//  Copyright © 2019 Eugene Belyakov. All rights reserved.
//

import UIKit

class MainFlowCoordinator: NSObject, FlowCoordinator {
    
    let window: UIWindow
    let services: ServicesProvider
    
    var navigationController: UINavigationController? {
        return window.rootViewController as? UINavigationController
    }
    
    var mainStoryboard: UIStoryboard? {
        return navigationController?.storyboard
    }
    
    var mapViewController: MapViewController? {
        return self.navigationController?.viewControllers.first as? MapViewController
    }
    
    init(window: UIWindow, services: ServicesProvider) {
        self.window = window
        self.services = services
    }
    
    func start() {
        self.mapViewController?.mapDataSource = VenuesLoader(api: self.services.networkingService)
        self.mapViewController?.router = self
        self.mapViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension MainFlowCoordinator: MapViewControllerRouter {
    func openDetailsForVenue(_ venue: Venue) {
        
        guard let detailsViewController = self.mainStoryboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? RestaurantDetailsViewController else {
            return
        }
        
        detailsViewController.venue = venue
        detailsViewController.api = self.services.networkingService
        
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
